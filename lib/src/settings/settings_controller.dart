import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_service.dart';

class SettingsController extends GetxController {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;
  var themeMode = ThemeMode.system.obs;

  var locale = Get.deviceLocale.obs; // Use the device locale as the default locale

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    themeMode.value = await _settingsService.themeMode();
    locale.value = await _settingsService.locale(); // Provide a default locale
    Get.updateLocale(locale.value!);
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == themeMode.value) return;
    themeMode.value = newThemeMode;
    await _settingsService.updateThemeMode(newThemeMode);
  }

  void updateLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    _settingsService.updateLocale(newLocale);
  }
}
