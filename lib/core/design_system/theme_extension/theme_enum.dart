import 'package:flutter/material.dart';

/// Enum representing different theme modes
enum ThemeModeEnum {
  light,
  dark,
  system;

  /// Convert ThemeModeEnum to Flutter's ThemeMode
  ThemeMode toThemeMode() {
    switch (this) {
      case ThemeModeEnum.light:
        return ThemeMode.light;
      case ThemeModeEnum.dark:
        return ThemeMode.dark;
      case ThemeModeEnum.system:
        return ThemeMode.system;
    }
  }

  /// Get the string name of the theme mode
  String get name {
    switch (this) {
      case ThemeModeEnum.light:
        return 'Light';
      case ThemeModeEnum.dark:
        return 'Dark';
      case ThemeModeEnum.system:
        return 'System';
    }
  }
}