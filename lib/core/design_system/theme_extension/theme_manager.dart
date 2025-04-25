import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

/// ThemeManager instance to be used throughout the app
final themeManager = ThemeManager();

/// Bloc implementation for theme management
class ThemeState {
  final ThemeModeEnum themeMode;

  ThemeState(this.themeMode);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeModeEnum.system)) {
    // Initialize from shared preferences
    themeManager.initialize().then((_) {
      emit(ThemeState(themeManager.currentTheme));
    });

    // Add listener for theme changes
    themeManager.addListener(_onThemeChanged);
  }

  void setTheme(ThemeModeEnum theme) {
    themeManager.setTheme(theme);
  }

  void _onThemeChanged(ThemeModeEnum theme) {
    emit(ThemeState(theme));
  }

  @override
  Future<void> close() {
    themeManager.removeListener(_onThemeChanged);
    return super.close();
  }
}

/// Application with theme support
class MyApp extends StatelessWidget {
  final Widget home;
  final String title;

  const MyApp({
    super.key,
    required this.home,
    this.title = 'App',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode.toThemeMode(),
            home: home,
          );
        },
      ),
    );
  }
}
