import 'package:flutter/material.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

import '../constants/storage_key.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark); // Default to dark mode

  //
  init() {
    bool result = PrefrencesetManagerService().getBool(StorageKey.theme) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PrefrencesetManagerService().setBool(StorageKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PrefrencesetManagerService().setBool(StorageKey.theme, true);
    }
  }

  // Helper method to check current mode
  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}