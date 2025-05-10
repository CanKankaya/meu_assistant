import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

import 'package:meu_assistant/constants/api_info.dart';
import 'package:meu_assistant/models/map_location.dart';
import 'package:meu_assistant/services/map_data.dart';

class MapService extends GetxController {
  final _controller = Completer<GoogleMapController>();
  final _campusCenter = LatLng(36.786659, 34.525297);
  LatLng get campusCenter => _campusCenter;
  final _markersVisible = true.obs;
  bool get markersVisible => _markersVisible.value;
  Set<Marker> _markers = {};
  Set<Marker> _ringStopMarkers = {};
  Function(LatLng)? onMarkerTapped;
  List<LatLng> _routePoints = [];
  List<LatLng> get routePoints => _routePoints;
  final lastSelectedMarker = Rx<LatLng?>(null);
  var isRouteLoading = false.obs;
  final _staticRouteVisible = false.obs;
  bool get staticRouteVisible => _staticRouteVisible.value;

  late BitmapDescriptor busStopIcon;

  @override
  void onInit() {
    super.onInit();
    _loadCustomIcons();
  }

  Future<void> _loadCustomIcons() async {
    busStopIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(32, 32)),
      'assets/icons/bus_stop.png',
    );
    update();
  }

  CameraPosition get initialCameraPosition {
    return CameraPosition(
      target: _campusCenter,
      zoom: 15.5,
    );
  }

  Set<Marker> getRingStopMarkers(BuildContext context) {
    final ringStops = getRingStops(context);
    _ringStopMarkers = ringStops.map((stop) {
      return Marker(
        markerId: MarkerId(stop.name),
        position: stop.position,
        icon: busStopIcon,
        visible: _staticRouteVisible.value,
        onTap: () {
          lastSelectedMarker.value = stop.position;
          if (onMarkerTapped != null) {
            onMarkerTapped!(lastSelectedMarker.value!);
          }
        },
      );
    }).toSet();

    return _ringStopMarkers;
  }

  Set<Marker> getMarkers(BuildContext context) {
    final locations = getLocations(context);
    _markers = locations.map((location) {
      return Marker(
        markerId: MarkerId(location!.name),
        position: location.position,
        infoWindow: InfoWindow(
          title: location.name,
          snippet: location.email,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        visible: _markers
            .firstWhere(
              (marker) => marker.markerId.value == location.name,
              orElse: () =>
                  Marker(markerId: MarkerId('')).copyWith(visibleParam: _markersVisible.value),
            )
            .visible,
        onTap: () {
          lastSelectedMarker.value = location.position;
          if (onMarkerTapped != null) {
            onMarkerTapped!(lastSelectedMarker.value!);
          }
        },
      );
    }).toSet();
    return _markers;
  }

  void toggleMarkers() {
    _markersVisible.value = !_markersVisible.value;
    _markers = _markers.map((marker) {
      return marker.copyWith(visibleParam: _markersVisible.value);
    }).toSet();
  }

  void toggleRingRoute() {
    _staticRouteVisible.value = !_staticRouteVisible.value;
    _ringStopMarkers = _ringStopMarkers.map((marker) {
      return marker.copyWith(visibleParam: _staticRouteVisible.value);
    }).toSet();
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onLongPress(LatLng position) {
    log('${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}');
  }

  Future<void> moveToLocation(LatLng location, {double? zoom}) async {
    final GoogleMapController controller = await _controller.future;
    if (zoom != null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(location, zoom));
    } else {
      controller.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

  Future<void> selectPin(MapLocation location) async {
    lastSelectedMarker.value = location.position;
    final GoogleMapController controller = await _controller.future;
    controller.showMarkerInfoWindow(MarkerId(location.name));
  }

  Future<String> loadMapStyle() async {
    return await rootBundle.loadString('assets/map_style.json');
  }

  Future<bool> requestLocationPermission() async {
    try {
      var status = await Permission.locationWhenInUse.status;
      if (status.isDenied) {
        status = await Permission.locationWhenInUse.request();
      }

      if (status.isPermanentlyDenied) {
        log('Location permission denied forever');
        return false;
      }

      return status.isGranted;
    } on PlatformException catch (e) {
      log('Location permission error: $e');
      return false;
    } catch (e) {
      log('Location permission error: $e');
      return false;
    }
  }

  Future<void> getRoute(LatLng start, LatLng end) async {
    isRouteLoading.value = true;
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleMapsApiKey,
        request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(end.latitude, end.longitude),
          mode: TravelMode.walking,
        ),
      );

      if (result.points.isNotEmpty) {
        _routePoints =
            result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
        result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();

        // Make the ring routes invisible
        toggleRingRoute();

        // Make other markers invisible
        _markersVisible.value = false;
        _markers = _markers.map((marker) {
          return marker.copyWith(visibleParam: false);
        }).toSet();
        // Make the routed pin visible
        _markers = _markers.map((marker) {
          if (marker.position == end) {
            return marker.copyWith(visibleParam: true);
          }
          return marker;
        }).toSet();
      } else {
        log('No route points found');
      }
    } catch (e) {
      log('Error getting route: $e');
    } finally {
      isRouteLoading.value = false;
    }
  }

  Future<LatLng?> getUserLocation() async {
    try {
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          log('Location service is disabled.');
          return null;
        }
      }

      var status = await Permission.locationWhenInUse.status;
      if (status.isDenied) {
        log('Location permission is denied.');
        return null;
      }

      LocationData locationData = await location.getLocation();
      //TODO Bug here for IOS Simulator only, cant get location. Test with real device
      return LatLng(locationData.latitude!, locationData.longitude!);
    } on PlatformException catch (e) {
      log('Location error: $e');
      return null;
    } catch (e) {
      log('Location error: $e');
      return null;
    }
  }

  void clearLastSelectedMarker() {
    lastSelectedMarker.value = null;
  }

  void clearRoute() {
    _routePoints.clear();
    _markersVisible.value = true;
    _markers = _markers.map((marker) {
      return marker.copyWith(visibleParam: true);
    }).toSet();

    if (!_staticRouteVisible.value) {
      toggleRingRoute();
    }
  }

  Future<void> setCameraToRoute() async {
    if (_routePoints.isEmpty) return;

    final GoogleMapController controller = await _controller.future;
    LatLngBounds bounds = LatLngBounds(
      southwest: _routePoints.reduce((a, b) => LatLng(
            a.latitude < b.latitude ? a.latitude : b.latitude,
            a.longitude < b.longitude ? a.longitude : b.longitude,
          )),
      northeast: _routePoints.reduce((a, b) => LatLng(
            a.latitude > b.latitude ? a.latitude : b.latitude,
            a.longitude > b.longitude ? a.longitude : b.longitude,
          )),
    );

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    controller.animateCamera(cameraUpdate);
  }
}
