import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class SettingsService {
  static const String themeModeKey = 'theme_mode';

  /// Loads the User's preferred ThemeMode from local storage.
  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(themeModeKey) ?? 0;
    return ThemeMode.values[themeModeIndex];
  }

  /// Persists the user's preferred ThemeMode to local storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, theme.index);
  }

  Future<Locale> locale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString('locale') ?? Get.deviceLocale?.languageCode ?? 'tr';
    log(prefs.getString('locale') ?? 'prefs.getString is null');
    log(Get.deviceLocale?.languageCode ?? 'Get.devicelocale is null');
    return Locale(localeString);
  }

  Future<void> updateLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }
}
