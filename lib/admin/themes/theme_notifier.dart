import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  static const String boxName = 'settings';
  static const String keyTheme = 'theme';

  ThemeNotifier() : super(ThemeMode.light) {
    final box = Hive.box(boxName);
    final storedTheme = box.get(keyTheme, defaultValue: 'light');
    if (storedTheme == 'dark') value = ThemeMode.dark;
  }

  void setTheme(String themeKey) {
    if (themeKey == 'light') {
      value = ThemeMode.light;
    } else {
      value = ThemeMode.dark;
    }
    Hive.box(boxName).put(keyTheme, themeKey);
  }
}