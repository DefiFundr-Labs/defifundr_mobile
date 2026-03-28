/// DeFiFundr Design System
///
/// Single entry point for all design system tokens and theme utilities.
///
/// Usage:
/// ```dart
/// import 'package:defifundr_mobile/core/design_system/design_system.dart';
/// ```
///
/// Access patterns:
/// - Colors:    `context.theme.colors.<token>`
/// - Fonts:     `context.theme.fonts.<token>`
/// - Dark mode: `context.isDarkMode`
/// - Assets:    `Assets.icons.<name>` / `Assets.images.<name>` (via flutter_gen)
library design_system;

// Color palette constants (raw values — prefer semantic tokens via theme extension)
export 'app_colors/app_colors.dart';

// ThemeExtension types — AppColorExtension, AppFontThemeExtension
export 'color_extension/app_color_extension.dart';
export 'font_extension/font_extension.dart';

// AppTheme (light/dark ThemeData factories) + ThemeGetter + AppThemeExtension
// Provides: context.theme, context.textTheme, context.isDarkMode,
//           context.theme.colors, context.theme.fonts
export 'theme_extension/app_theme_extension.dart';

// Theme state management (ThemeCubit, ThemeManager, ThemeEnum)
export 'theme_extension/theme_cubit.dart';
export 'theme_extension/theme_enum.dart';
export 'theme_extension/theme_manager.dart';
