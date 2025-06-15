import 'package:defifundr_mobile/core/design_system/theme_extension/theme_enum.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
