import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';
import '../color_extension/app_color_extension.dart';
import '../font_extension/font_extension.dart';

/// AppTheme - Main theme configuration for the application
class AppTheme {
  // Light theme color configurations
  static final _lightAppColorss = AppColorExtension(
    // Text colors
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    textQuaternary: AppColors.textQuaternary,
    textWhite: AppColors.textWhite,

    // Constant/Brand colors
    constantDefault: AppColors.constantDefault,
    constantDefaultBorder: AppColors.constantDefaultBorder,
    brandDefault: AppColors.brandDefault,
    brandContrast: AppColors.brandContrast,
    brandHover: AppColors.brandHover,
    brandActive: AppColors.brandActive,
    brandStroke: AppColors.brandStroke,
    brandFill: AppColors.brandFill,

    // Blue colors
    blueDefault: AppColors.blueDefault,
    blueHover: AppColors.blueHover,
    blueActive: AppColors.blueActive,
    blueStroke: AppColors.blueStroke,
    blueFill: AppColors.blueFill,

    // Green colors
    greenDefault: AppColors.greenDefault,
    greenHover: AppColors.greenHover,
    greenActive: AppColors.greenActive,
    greenStroke: AppColors.greenStroke,
    greenFill: AppColors.greenFill,

    // Gray colors
    grayPrimary: AppColors.grayPrimary,
    graySecondary: AppColors.graySecondary,
    grayTertiary: AppColors.grayTertiary,
    grayQuaternary: AppColors.grayQuaternary,

    // Yellow colors
    yellowDefault: AppColors.yellowDefault,
    yellowHover: AppColors.yellowHover,
    yellowActive: AppColors.yellowActive,
    yellowStroke: AppColors.yellowStroke,
    yellowFill: AppColors.yellowFill,

    // Orange colors
    orangeDefault: AppColors.orangeDefault,
    orangeHover: AppColors.orangeHover,
    orangeActive: AppColors.orangeActive,
    orangeStroke: AppColors.orangeStroke,
    orangeFill: AppColors.orangeFill,

    // Red colors
    redDefault: AppColors.redDefault,
    redHover: AppColors.redHover,
    redActive: AppColors.redActive,
    redStroke: AppColors.redStroke,
    redFill: AppColors.redFill,

    // Pink colors
    pinkDefault: AppColors.pinkDefault,
    pinkHover: AppColors.pinkHover,
    pinkActive: AppColors.pinkActive,
    pinkStroke: AppColors.pinkStroke,
    pinkFill: AppColors.pinkFill,

    // Background colors
    bgB0: AppColors.bgB0,
    bgB1: AppColors.bgB1,
    bgB2: AppColors.bgB2,
    bgB3: AppColors.bgB3,

    // Surface colors
    surface: AppColors.surface,
    surfaceCard: AppColors.surfaceCard,

    // Button/Interactive colors
    inactiveButton: AppColors.inactiveButton,
    activeButton: AppColors.activeButton,
    buttonTertiary: AppColors.buttonTertiary,
    buttonSecondary: AppColors.buttonSecondary,

    // Icon colors
    iconRed: AppColors.iconRed,
    iconBlue: AppColors.iconBlue,
    textHighlightBlue: AppColors.textHighlightBlue,
  );

  // Dark theme color configurations
  static final _darkAppColorss = AppColorExtension(
    // Text colors
    textPrimary: AppColorDark.textPrimary,
    textSecondary: AppColorDark.textSecondary,
    textTertiary: AppColorDark.textTertiary,
    textQuaternary: AppColorDark.textQuaternary,
    textWhite: AppColorDark.textWhite,

    // Constant/Brand colors
    constantDefault: AppColorDark.constantDefault,
    constantDefaultBorder: AppColorDark.constantDefaultBorder,
    brandDefault: AppColorDark.brandDefault,
    brandContrast: AppColorDark.brandContrast,
    brandHover: AppColorDark.brandHover,
    brandActive: AppColorDark.brandActive,
    brandStroke: AppColorDark.brandStroke,
    brandFill: AppColorDark.brandFill,

    // Blue colors
    blueDefault: AppColorDark.blueDefault,
    blueHover: AppColorDark.blueHover,
    blueActive: AppColorDark.blueActive,
    blueStroke: AppColorDark.blueStroke,
    blueFill: AppColorDark.blueFill,

    // Green colors
    greenDefault: AppColorDark.greenDefault,
    greenHover: AppColorDark.greenHover,
    greenActive: AppColorDark.greenActive,
    greenStroke: AppColorDark.greenStroke,
    greenFill: AppColorDark.greenFill,

    // Gray colors
    grayPrimary: AppColorDark.grayPrimary,
    graySecondary: AppColorDark.graySecondary,
    grayTertiary: AppColorDark.grayTertiary,
    grayQuaternary: AppColorDark.grayQuaternary,

    // Yellow colors
    yellowDefault: AppColorDark.yellowDefault,
    yellowHover: AppColorDark.yellowHover,
    yellowActive: AppColorDark.yellowActive,
    yellowStroke: AppColorDark.yellowStroke,
    yellowFill: AppColorDark.yellowFill,

    // Orange colors
    orangeDefault: AppColorDark.orangeDefault,
    orangeHover: AppColorDark.orangeHover,
    orangeActive: AppColorDark.orangeActive,
    orangeStroke: AppColorDark.orangeStroke,
    orangeFill: AppColorDark.orangeFill,

    // Red colors
    redDefault: AppColorDark.redDefault,
    redHover: AppColorDark.redHover,
    redActive: AppColorDark.redActive,
    redStroke: AppColorDark.redStroke,
    redFill: AppColorDark.redFill,

    // Pink colors
    pinkDefault: AppColorDark.pinkDefault,
    pinkHover: AppColorDark.pinkHover,
    pinkActive: AppColorDark.pinkActive,
    pinkStroke: AppColorDark.pinkStroke,
    pinkFill: AppColorDark.pinkFill,

    // Background colors
    bgB0: AppColorDark.bgB0,
    bgB1: AppColorDark.bgB1,
    bgB2: AppColorDark.bgB2,
    bgB3: AppColorDark.bgB3,

    // Surface colors
    surface: AppColorDark.surface,
    surfaceCard: AppColorDark.surfaceCard,

    // Button/Interactive colors
    inactiveButton: AppColorDark.inactiveButton,
    activeButton: AppColorDark.activeButton,
    buttonTertiary: AppColorDark.buttonTertiary,
    buttonSecondary: AppColorDark.buttonSecondary,

    // Icon colors
    iconRed: AppColorDark.iconRed,
    iconBlue: AppColorDark.iconBlue,
    textHighlightBlue: AppColorDark.textHighlightBlue,
  );

  // Font styles for light theme
  static final _lightFontTheme = AppFontThemeExtension(
    // Headings
    heading1Bold: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1SemiBold: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1Medium: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1Regular: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    heading2Bold: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2SemiBold: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2Medium: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2Regular: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    heading3Bold: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3SemiBold: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3Medium: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3Regular: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    // Text styles
    textLgBold: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgSemiBold: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgMedium: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgRegular: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    textBaseBold: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseSemiBold: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseMedium: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseRegular: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    textMdBold: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdSemiBold: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdMedium: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdRegular: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    textSmBold: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmSemiBold: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmMedium: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmRegular: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    textXsBold: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsSemiBold: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsMedium: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsRegular: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),

    // Legacy styles
    headerLarger: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    headerSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    subHeader: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textTertiary,
      fontFamily: 'Inter',
    ),
    bodyMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
  );

  // Font styles for dark theme
  static final _darkFontTheme = AppFontThemeExtension(
    // Headings
    heading1Bold: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1SemiBold: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1Medium: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading1Regular: const TextStyle(
      fontSize: 32,
      height: 1.25, // 40px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    heading2Bold: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2SemiBold: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2Medium: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading2Regular: const TextStyle(
      fontSize: 24,
      height: 1.33, // 32px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    heading3Bold: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3SemiBold: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3Medium: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    heading3Regular: const TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    // Text styles
    textLgBold: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgSemiBold: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgMedium: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textLgRegular: const TextStyle(
      fontSize: 18,
      height: 1.33, // 24px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    textBaseBold: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseSemiBold: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseMedium: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textBaseRegular: const TextStyle(
      fontSize: 16,
      height: 1.5, // 24px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    textMdBold: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdSemiBold: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdMedium: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textMdRegular: const TextStyle(
      fontSize: 14,
      height: 1.43, // 20px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    textSmBold: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmSemiBold: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmMedium: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textSmRegular: const TextStyle(
      fontSize: 12,
      height: 1.33, // 16px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    textXsBold: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsSemiBold: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w600,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsMedium: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w500,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    textXsRegular: const TextStyle(
      fontSize: 10,
      height: 1.4, // 14px line height
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),

    // Legacy styles
    headerLarger: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    headerSmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
    subHeader: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorDark.textTertiary,
      fontFamily: 'Inter',
    ),
    bodyMedium: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColorDark.textPrimary,
      fontFamily: 'Inter',
    ),
  );

  // Define the static light theme configurations
  static final light = () {
    final defaultTheme = ThemeData.light();

    return defaultTheme.copyWith(
      colorScheme: _lightAppColorss.toColorScheme(Brightness.light),
      scaffoldBackgroundColor: _lightAppColorss.bgB1,
      appBarTheme: AppBarTheme(
        color: _lightAppColorss.bgB0,
        titleTextStyle: _lightFontTheme.heading2Bold,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: _lightAppColorss.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: TextTheme(
        // Map Material's text theme to our custom styles
        displayLarge: _lightFontTheme.heading1Bold,
        displayMedium: _lightFontTheme.heading2Bold,
        displaySmall: _lightFontTheme.heading3Bold,

        headlineLarge: _lightFontTheme.heading1SemiBold,
        headlineMedium: _lightFontTheme.heading2SemiBold,
        headlineSmall: _lightFontTheme.heading3SemiBold,

        titleLarge: _lightFontTheme.textLgBold,
        titleMedium: _lightFontTheme.textBaseBold,
        titleSmall: _lightFontTheme.textMdBold,

        bodyLarge: _lightFontTheme.textLgRegular,
        bodyMedium: _lightFontTheme.textBaseRegular,
        bodySmall: _lightFontTheme.textMdRegular,

        labelLarge: _lightFontTheme.textSmBold,
        labelMedium: _lightFontTheme.textSmRegular,
        labelSmall: _lightFontTheme.textXsRegular,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightAppColorss.blueDefault,
          foregroundColor: _lightAppColorss.textWhite,
          disabledBackgroundColor: _lightAppColorss.inactiveButton,
          disabledForegroundColor: _lightAppColorss.textPrimary,
          textStyle: _lightFontTheme.textMdBold,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _lightAppColorss.blueDefault,
          disabledForegroundColor: _lightAppColorss.textTertiary,
          textStyle: _lightFontTheme.textMdBold,
          side: BorderSide(color: _lightAppColorss.blueDefault),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _lightAppColorss.blueDefault,
          disabledForegroundColor: _lightAppColorss.textTertiary,
          textStyle: _lightFontTheme.textMdBold,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: _lightAppColorss.bgB0,
        filled: true,
        labelStyle: _lightFontTheme.textMdRegular
            .copyWith(color: _lightAppColorss.textTertiary),
        hintStyle: _lightFontTheme.textMdRegular
            .copyWith(color: _lightAppColorss.textTertiary),
        errorStyle: _lightFontTheme.textSmRegular
            .copyWith(color: _lightAppColorss.redDefault),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: _lightAppColorss.grayQuaternary),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _lightAppColorss.grayQuaternary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _lightAppColorss.blueDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _lightAppColorss.redDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _lightAppColorss.redDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      extensions: [
        _lightAppColorss,
        _lightFontTheme,
      ],
    );
  }();

  static final dark = () {
    final defaultTheme = ThemeData.dark();

    return defaultTheme.copyWith(
      colorScheme: _darkAppColorss.toColorScheme(Brightness.dark),
      scaffoldBackgroundColor: _darkAppColorss.bgB1,
      appBarTheme: AppBarTheme(
        color: _darkAppColorss.bgB0,
        titleTextStyle: _darkFontTheme.heading2Bold,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: _darkAppColorss.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      textTheme: TextTheme(
        // Map Material's text theme to our custom styles
        displayLarge: _darkFontTheme.heading1Bold,
        displayMedium: _darkFontTheme.heading2Bold,
        displaySmall: _darkFontTheme.heading3Bold,

        headlineLarge: _darkFontTheme.heading1SemiBold,
        headlineMedium: _darkFontTheme.heading2SemiBold,
        headlineSmall: _darkFontTheme.heading3SemiBold,

        titleLarge: _darkFontTheme.textLgBold,
        titleMedium: _darkFontTheme.textBaseBold,
        titleSmall: _darkFontTheme.textMdBold,

        bodyLarge: _darkFontTheme.textLgRegular,
        bodyMedium: _darkFontTheme.textBaseRegular,
        bodySmall: _darkFontTheme.textMdRegular,

        labelLarge: _darkFontTheme.textSmBold,
        labelMedium: _darkFontTheme.textSmRegular,
        labelSmall: _darkFontTheme.textXsRegular,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkAppColorss.blueDefault,
          foregroundColor: _darkAppColorss.textWhite,
          disabledBackgroundColor: _darkAppColorss.inactiveButton,
          disabledForegroundColor: _darkAppColorss.textPrimary,
          textStyle: _darkFontTheme.textMdBold,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkAppColorss.blueDefault,
          disabledForegroundColor: _darkAppColorss.textTertiary,
          textStyle: _darkFontTheme.textMdBold,
          side: BorderSide(color: _darkAppColorss.blueDefault),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _darkAppColorss.blueDefault,
          disabledForegroundColor: _darkAppColorss.textTertiary,
          textStyle: _darkFontTheme.textMdBold,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: _darkAppColorss.bgB0,
        filled: true,
        labelStyle: _darkFontTheme.textMdRegular
            .copyWith(color: _darkAppColorss.textTertiary),
        hintStyle: _darkFontTheme.textMdRegular
            .copyWith(color: _darkAppColorss.textTertiary),
        errorStyle: _darkFontTheme.textSmRegular
            .copyWith(color: _darkAppColorss.redDefault),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: _darkAppColorss.grayQuaternary),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _darkAppColorss.grayQuaternary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _darkAppColorss.blueDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _darkAppColorss.redDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _darkAppColorss.redDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      extensions: [
        _darkAppColorss,
        _darkFontTheme,
      ],
    );
  }();
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension AppThemeExtension on ThemeData {
  AppColorExtension get colors =>
      extension<AppColorExtension>() ?? AppTheme._lightAppColorss;

  AppFontThemeExtension get fonts =>
      extension<AppFontThemeExtension>() ?? AppTheme._lightFontTheme;
}
