import 'package:defifundr_mobile/core/design_system/theme_extension/theme_enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to manage the theme state using SharedPreferences
class ThemeManager {
  static const String _themeKey = 'app_theme';
  ThemeModeEnum _currentTheme = ThemeModeEnum.system;
  final List<Function(ThemeModeEnum)> _listeners = [];

  /// Function to initialize the theme manager
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex != null) {
      _currentTheme = ThemeModeEnum
          .values[themeIndex.clamp(0, ThemeModeEnum.values.length - 1)];
    }
  }

  /// Get the current theme mode
  ThemeModeEnum get currentTheme => _currentTheme;

  /// Get the Flutter ThemeMode
  ThemeMode get themeMode => _currentTheme.toThemeMode();

  /// Function to set the theme
  Future<void> setTheme(ThemeModeEnum theme) async {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);

      // Notify all listeners
      for (final listener in _listeners) {
        listener(theme);
      }
    }
  }

  /// Add a listener for theme changes
  void addListener(Function(ThemeModeEnum) listener) {
    _listeners.add(listener);
  }

  /// Remove a listener
  void removeListener(Function(ThemeModeEnum) listener) {
    _listeners.remove(listener);
  }

  /// Check if the current theme is dark
  bool get isDarkMode {
    if (_currentTheme == ThemeModeEnum.system) {
      // Get system brightness when in system mode
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _currentTheme == ThemeModeEnum.dark;
  }
}
