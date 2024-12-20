import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meu_assistant/models/map_location.dart';

final List<LatLng> staticRoutePoints = [
  //TODO drawn wrongly, do it again
  LatLng(36.780064, 34.531959),
  LatLng(36.781260, 34.531293),
  LatLng(36.783115, 34.528826),
  LatLng(36.783868, 34.528114),
  LatLng(36.783850, 34.527447),
  LatLng(36.783802, 34.527078),
  LatLng(36.783802, 34.526709),
  LatLng(36.783825, 34.526554),
  LatLng(36.783856, 34.526472),
  LatLng(36.783925, 34.526405),
  LatLng(36.784085, 34.526285),
  LatLng(36.784466, 34.526021),
  LatLng(36.785292, 34.525456),
  LatLng(36.785866, 34.525076),
  LatLng(36.785947, 34.524966),
  LatLng(36.786271, 34.524413),
  LatLng(36.786531, 34.523963),
  LatLng(36.786598, 34.523870),
  LatLng(36.786653, 34.523817),
  LatLng(36.786731, 34.523762),
  LatLng(36.786867, 34.523679),
  LatLng(36.787128, 34.523495),
  LatLng(36.787464, 34.523250),
  LatLng(36.787668, 34.523109),
  LatLng(36.787705, 34.523084),
  LatLng(36.787833, 34.523077),
  LatLng(36.787954, 34.523077),
  LatLng(36.788077, 34.523096),
  LatLng(36.788283, 34.523145),
  LatLng(36.788512, 34.523219),
  LatLng(36.788654, 34.523283),
  LatLng(36.788725, 34.523303),
  LatLng(36.788769, 34.523244),
  LatLng(36.789077, 34.523044),
  LatLng(36.789303, 34.522908),
  LatLng(36.789420, 34.522813),
  LatLng(36.789809, 34.522401),
  LatLng(36.790035, 34.522163),
  LatLng(36.790586, 34.521763),
  LatLng(36.791055, 34.521446),
  LatLng(36.791281, 34.521287),
  LatLng(36.791658, 34.521142),
  LatLng(36.791913, 34.521075),
  LatLng(36.792109, 34.521098),
  LatLng(36.792170, 34.521126),
  LatLng(36.792244, 34.521194),
  LatLng(36.792314, 34.521312),
  LatLng(36.792380, 34.521444),
  LatLng(36.792464, 34.521643),
  LatLng(36.792520, 34.521812),
  LatLng(36.792569, 34.522015),
  LatLng(36.792583, 34.522208),
  LatLng(36.792573, 34.522528),
  LatLng(36.792542, 34.522694),
  LatLng(36.792495, 34.522849),
  LatLng(36.792416, 34.522979),
  LatLng(36.792314, 34.523113),
  LatLng(36.792154, 34.523275),
  LatLng(36.791873, 34.523533),
  LatLng(36.791873, 34.523540),
  LatLng(36.791555, 34.523863),
  LatLng(36.790841, 34.524533),
  LatLng(36.790727, 34.524633),
  LatLng(36.790516, 34.524799),
  LatLng(36.790491, 34.524817),
  LatLng(36.790405, 34.524818),
  LatLng(36.790197, 34.525005),
  LatLng(36.790050, 34.525130),
  LatLng(36.789785, 34.525693),
  LatLng(36.789741, 34.525785),
  LatLng(36.789722, 34.525877),
  LatLng(36.789699, 34.526070),
  LatLng(36.789670, 34.526486),
  LatLng(36.789652, 34.526722),
  LatLng(36.789638, 34.526794),
  LatLng(36.789562, 34.527045),
  LatLng(36.789512, 34.527259),
  LatLng(36.789489, 34.527402),
  LatLng(36.789468, 34.527590),
  LatLng(36.789435, 34.527879),
  LatLng(36.789421, 34.528017),
  LatLng(36.789417, 34.528128),
  LatLng(36.789427, 34.528270),
  LatLng(36.789440, 34.528338),
  LatLng(36.789469, 34.528425),
  LatLng(36.789506, 34.528478),
  LatLng(36.789548, 34.528517),
  LatLng(36.789616, 34.528566),
  LatLng(36.789673, 34.528606),
  LatLng(36.789657, 34.528674),
  LatLng(36.789586, 34.528886),
  LatLng(36.789506, 34.529055),
  LatLng(36.789421, 34.529192),
  LatLng(36.789210, 34.529539),
  LatLng(36.789109, 34.529702),
  LatLng(36.789003, 34.529871),
  LatLng(36.788841, 34.530081),
  LatLng(36.788699, 34.530264),
  LatLng(36.788485, 34.530541),
  LatLng(36.788417, 34.530624),
  LatLng(36.788389, 34.530689),
  LatLng(36.788332, 34.530795),
  LatLng(36.788059, 34.531265),
  LatLng(36.787892, 34.531549),
  LatLng(36.787736, 34.531791),
  LatLng(36.787638, 34.531992),
  LatLng(36.787555, 34.532151),
  LatLng(36.787450, 34.532473),
  LatLng(36.787421, 34.532631),
  LatLng(36.787409, 34.532799),
  LatLng(36.787425, 34.532967),
  LatLng(36.787655, 34.533466),
  LatLng(36.787835, 34.533855),
  LatLng(36.787860, 34.533926),
  LatLng(36.787874, 34.534003),
  LatLng(36.787872, 34.534085),
  LatLng(36.787849, 34.534220),
  LatLng(36.787795, 34.534359),
  LatLng(36.787751, 34.534453),
  LatLng(36.787641, 34.534674),
  LatLng(36.787606, 34.534744),
  LatLng(36.787564, 34.534820),
  LatLng(36.787410, 34.535051),
  LatLng(36.787342, 34.535134),
  LatLng(36.787261, 34.535228),
  LatLng(36.787144, 34.535323),
  LatLng(36.786735, 34.535595),
  LatLng(36.786648, 34.535651),
  LatLng(36.786560, 34.535790),
  LatLng(36.786510, 34.535901),
  LatLng(36.786481, 34.536002),
  LatLng(36.786457, 34.536139),
  LatLng(36.786410, 34.536347),
  LatLng(36.786381, 34.536451),
  LatLng(36.786374, 34.536583),
  LatLng(36.786325, 34.536939),
  LatLng(36.786194, 34.537396),
  LatLng(36.786103, 34.537595),
  LatLng(36.785932, 34.537935),
  LatLng(36.785727, 34.538349),
  LatLng(36.785696, 34.538402),
  LatLng(36.785712, 34.538465),
  LatLng(36.785659, 34.538544),
  LatLng(36.785631, 34.538558),
  LatLng(36.785558, 34.538840),
  LatLng(36.785475, 34.539106),
  LatLng(36.785415, 34.539311),
  LatLng(36.785473, 34.539453),
  LatLng(36.785532, 34.539516),
  LatLng(36.785675, 34.539598),
  LatLng(36.786202, 34.539343),
  LatLng(36.786751, 34.539068),
  LatLng(36.787303, 34.538791),
  LatLng(36.787679, 34.538618),
  LatLng(36.787995, 34.538499),
  LatLng(36.788097, 34.538455),
  LatLng(36.788480, 34.538429),
  LatLng(36.788886, 34.538373),
  LatLng(36.789196, 34.538424),
  LatLng(36.789328, 34.538443), //KYK Kiz Yurdu
];

//TODO DENİZ Add Teknopark pin
List<MapLocation> getLocations(BuildContext context) {
  return [
    MapLocation(
        name: AppLocalizations.of(context)!.loc_1,
        position: LatLng(36.785369, 34.526026),
        email: "muhendislik@mersin.edu.tr",
        phones: ["324 361 00 33", "324 361 00 01"]),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_2,
      position: LatLng(36.786103, 34.525679),
      //no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_3,
      position: LatLng(36.786228, 34.526015),
      //no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_4,
      position: LatLng(36.783297, 34.527555),
      phones: ["324 361 0018", "324 361 00 01", "324 361 00 17"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_5,
      position: LatLng(36.783277, 34.528045),
      email: "ydilleryo@mersin.edu.tr",
      phones: ["324 361 00 38", "324 361 00 01", "324 361 02 43"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_6,
      position: LatLng(36.782376, 34.528113),
      email: "teknikbilimler@mersin.edu.tr",
      phones: ["324 361 00 38", "324 361 00 01", "324 361 00 43"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_7,
      position: LatLng(36.783463, 34.528003),
      email: "",
      phones: ["324 361 00 01", "324 361 03 43"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_8,
      position: LatLng(36.783488, 34.528069),
      email: "",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_9,
      position: LatLng(36.783584, 34.526420),
      email: "meuoidb@mersin.edu.tr",
      phones: ["324 361 06 48", "324 361 01 00 "],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_10,
      position: LatLng(36.783482, 34.526383),
      email: "bidb@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 06 24", "324 361 04 79"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_11,
      position: LatLng(36.784709, 34.526651),
      email: "iktisat@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 00 56"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_12,
      position: LatLng(36.784931, 34.527243),
      email: "konservatuvar@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 00 29"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_13,
      position: LatLng(36.786228, 34.525563),
      email: "basin@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 00 64", "324 361 00 63"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_14,
      position: LatLng(36.785967, 34.525493),
      email: "baum@mersin.edu.tr",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_15,
      position: LatLng(36.786951, 34.525335),
      //no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_16,
      position: LatLng(36.786666, 34.524407),
      //no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_17,
      position: LatLng(36.787275, 34.526067),
      //no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_18,
      position: LatLng(36.788089, 34.523792),
      email: "saglikyo@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 05 81", "324 361 05 71"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_19,
      position: LatLng(36.788243, 34.524717),
      email: "insanvetoplum@mersin.edu.tr",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_20,
      position: LatLng(36.783510, 34.531395),
      email: "pdrm@mersin.edu.tr",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_21,
      position: LatLng(36.788734, 34.523508),
      email: "iletisim@mersin.edu.tr",
      phones: ["324 361 02 23", "324 361 00 01", "324 361 04 93"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_22,
      position: LatLng(36.788765, 34.523086),
      email: "sosyalbilimler@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 02 87"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_23,
      position: LatLng(36.788751, 34.523013),
      email: "sksdb@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 00 26", "324 361 00 27", "324 361 00 96"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_24,
      position: LatLng(36.789564, 34.523347),
      email: "hemsirelik@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 05 81", "324 361 05 71"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_25,
      position: LatLng(36.789250, 34.524011),
      email: "ileriteknoloji@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 01 53"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_26,
      position: LatLng(36.790392, 34.522605),
      email: "mimarlik.sek@mersin.edu.tr",
      phones: ["324 361 06 08"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_27,
      position: LatLng(36.790380, 34.522387),
      email: "akkent@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 01 48"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_28,
      position: LatLng(36.790555, 34.522456),
      email: "biamer@mersin.edu.tr",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_29,
      position: LatLng(36.790834, 34.522611),
      email: "guzelsanatlar@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 00 68", "324 361 03 07"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_30,
      position: LatLng(36.790922, 34.522129),
      email: "takitekyo@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 07 83"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_31,
      position: LatLng(36.791756, 34.522240),
      email: "turizmfakultesi@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 07 51"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_32,
      position: LatLng(36.791677, 34.522004),
      email: "ilahiyat@mersin.edu.tr",
      phones: ["324 361 00 01"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_33,
      position: LatLng(36.790947, 34.520165),
      email: "egitim@mersin.edu.tr",
      phones: ["324 361 00 01", "324 341 28 23"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_34,
      position: LatLng(36.790417, 34.526135),
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_35,
      position: LatLng(36.792636, 34.519330),
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_36,
      position: LatLng(36.788564, 34.529016),
      email: "sbf@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 01 27"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_37,
      position: LatLng(36.788219, 34.528773),
      email: "bedenyo@mersin.edu.tr",
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_38,
      position: LatLng(36.788326, 34.529049),
      email: "bedenegitimi@mersin.edu.tr",
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_39,
      position: LatLng(36.787034, 34.530547),
      email: "sbmyo@mersin.edu.tr",
      phones: ["324 361 00 01", "324  361 03 03", "324 361 08 88"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_40,
      position: LatLng(36.788066, 34.532647),
      email: "dishek@mersin.edu.tr",
      phones: ["324 361 00 01", "324 361 03 69"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_41,
      position: LatLng(36.788205, 34.532797),
      email: "saglikhizmetleri@mersin.edu.tr",
      phones: ["324 361 00 01", "324 234 64 10"],
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_42,
      position: LatLng(36.786994, 34.534526),
      email: "tipfakultesi@mersin.edu.tr",
      phones: ["324 341 24 00", "324 241 00 00"],
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_43,
      position: LatLng(36.785483, 34.536800),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_44,
      position: LatLng(36.784434, 34.534804),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_45,
      position: LatLng(36.789305, 34.538119),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_46,
      position: LatLng(36.784559, 34.530455),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_47,
      position: LatLng(36.783707, 34.536441),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_48,
      position: LatLng(36.782770, 34.538749),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_49,
      position: LatLng(36.787880, 34.524955),
      // no email and phone
    ),
    MapLocation(
      //TODO DENİZ Fix position
      name: AppLocalizations.of(context)!.loc_50,
      position: LatLng(36.771218, 34.538934),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_51,
      position: LatLng(36.786104, 34.524391),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_52,
      position: LatLng(36.783973, 34.526185),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_53,
      position: LatLng(36.787495, 34.529245),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_54,
      position: LatLng(36.787946, 34.529430),
      // no email and phone
    ),
    MapLocation(
      name: AppLocalizations.of(context)!.loc_55,
      position: LatLng(36.788371, 34.533354),
      // no email and phone
    ),
  ];
}
