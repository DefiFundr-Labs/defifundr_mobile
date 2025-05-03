import 'package:flutter/material.dart';

/// `ThemeExtension` for app custom colors.
///
/// This extension includes colors from the app palette and can be easily used
/// throughout the app for consistent theming.
///
/// Usage example: `Theme.of(context).extension<AppColorExtension>()?.textPrimary`.
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    // Text colors
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textQuaternary,
    required this.textWhite,

    // Constant/Brand colors
    required this.constantDefault,
    required this.constantDefaultBorder,
    required this.brandDefault,
    required this.brandContrast,
    required this.brandDefaultContrast,
    required this.brandHover,
    required this.brandActive,
    required this.brandStroke,
    required this.brandFill,

    // Blue colors
    required this.blueDefault,
    required this.blueHover,
    required this.blueActive,
    required this.blueStroke,
    required this.blueFill,

    // Green colors
    required this.greenDefault,
    required this.greenHover,
    required this.greenActive,
    required this.greenStroke,
    required this.greenFill,

    // Gray colors
    required this.grayPrimary,
    required this.graySecondary,
    required this.grayTertiary,
    required this.grayQuaternary,

    // Yellow colors
    required this.yellowDefault,
    required this.yellowHover,
    required this.yellowActive,
    required this.yellowStroke,
    required this.yellowFill,

    // Orange colors
    required this.orangeDefault,
    required this.orangeHover,
    required this.orangeActive,
    required this.orangeStroke,
    required this.orangeFill,

    // Red colors
    required this.redDefault,
    required this.redHover,
    required this.redActive,
    required this.redStroke,
    required this.redFill,

    // Pink colors
    required this.pinkDefault,
    required this.pinkHover,
    required this.pinkActive,
    required this.pinkStroke,
    required this.pinkFill,

    // Background colors
    required this.bgB0,
    required this.bgB1,
    required this.bgB2,
    required this.bgB3,

    // Surface colors
    required this.surface,
    required this.surfaceCard,

    // Button/Interactive colors
    required this.inactiveButton,
    required this.activeButton,
    required this.buttonTertiary,
    required this.buttonSecondary,

    // Icon colors
    required this.iconRed,
    required this.iconBlue,
    required this.textHighlightBlue,

    //Miscellaneous colors
    required this.contrastBlack,
    required this.contrastWhite,
    required this.strokeSecondary,
  });

  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textQuaternary;
  final Color textWhite;

  // Constant/Brand colors
  final Color constantDefault;
  final Color constantDefaultBorder;
  final Color brandDefault;
  final Color brandContrast;
  final Color brandDefaultContrast;
  final Color brandHover;
  final Color brandActive;
  final Color brandStroke;
  final Color brandFill;

  // Blue colors
  final Color blueDefault;
  final Color blueHover;
  final Color blueActive;
  final Color blueStroke;
  final Color blueFill;

  // Green colors
  final Color greenDefault;
  final Color greenHover;
  final Color greenActive;
  final Color greenStroke;
  final Color greenFill;

  // Gray colors
  final Color grayPrimary;
  final Color graySecondary;
  final Color grayTertiary;
  final Color grayQuaternary;

  // Yellow colors
  final Color yellowDefault;
  final Color yellowHover;
  final Color yellowActive;
  final Color yellowStroke;
  final Color yellowFill;

  // Orange colors
  final Color orangeDefault;
  final Color orangeHover;
  final Color orangeActive;
  final Color orangeStroke;
  final Color orangeFill;

  // Red colors
  final Color redDefault;
  final Color redHover;
  final Color redActive;
  final Color redStroke;
  final Color redFill;

  // Pink colors
  final Color pinkDefault;
  final Color pinkHover;
  final Color pinkActive;
  final Color pinkStroke;
  final Color pinkFill;

  // Background colors
  final Color bgB0;
  final Color bgB1;
  final Color bgB2;
  final Color bgB3;

  // Surface colors
  final Color surface;
  final Color surfaceCard;

  // Button/Interactive colors
  final Color inactiveButton;
  final Color activeButton;
  final Color buttonTertiary;
  final Color buttonSecondary;

  // Icon colors
  final Color iconRed;
  final Color iconBlue;
  final Color textHighlightBlue;

  //Miscellaneous colors
  final Color contrastBlack;
  final Color contrastWhite;
  final Color strokeSecondary;

  @override
  ThemeExtension<AppColorExtension> copyWith({
    // Text colors
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textQuaternary,
    Color? textWhite,

    // Constant/Brand colors
    Color? constantDefault,
    Color? constantDefaultBorder,
    Color? brandDefault,
    Color? brandContrast,
    Color? brandDefaultContrast,
    Color? brandHover,
    Color? brandActive,
    Color? brandStroke,
    Color? brandFill,

    // Blue colors
    Color? blueDefault,
    Color? blueHover,
    Color? blueActive,
    Color? blueStroke,
    Color? blueFill,

    // Green colors
    Color? greenDefault,
    Color? greenHover,
    Color? greenActive,
    Color? greenStroke,
    Color? greenFill,

    // Gray colors
    Color? grayPrimary,
    Color? graySecondary,
    Color? grayTertiary,
    Color? grayQuaternary,

    // Yellow colors
    Color? yellowDefault,
    Color? yellowHover,
    Color? yellowActive,
    Color? yellowStroke,
    Color? yellowFill,

    // Orange colors
    Color? orangeDefault,
    Color? orangeHover,
    Color? orangeActive,
    Color? orangeStroke,
    Color? orangeFill,

    // Red colors
    Color? redDefault,
    Color? redHover,
    Color? redActive,
    Color? redStroke,
    Color? redFill,

    // Pink colors
    Color? pinkDefault,
    Color? pinkHover,
    Color? pinkActive,
    Color? pinkStroke,
    Color? pinkFill,

    // Background colors
    Color? bgB0,
    Color? bgB1,
    Color? bgB2,
    Color? bgB3,

    // Surface colors
    Color? surface,
    Color? surfaceCard,

    // Button/Interactive colors
    Color? inactiveButton,
    Color? activeButton,
    Color? buttonTertiary,
    Color? buttonSecondary,

    // Icon colors
    Color? iconRed,
    Color? iconBlue,
    Color? textHighlightBlue,

    //Miscellaneous colors
    Color? contrastBlack,
    Color? contrastWhite,
    Color? strokeSecondary,
  }) {
    return AppColorExtension(
      // Text colors
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textQuaternary: textQuaternary ?? this.textQuaternary,
      textWhite: textWhite ?? this.textWhite,

      // Constant/Brand colors
      constantDefault: constantDefault ?? this.constantDefault,
      constantDefaultBorder: constantDefaultBorder ?? this.constantDefaultBorder,
      brandDefault: brandDefault ?? this.brandDefault,
      brandContrast: brandContrast ?? this.brandContrast,
      brandDefaultContrast: brandDefaultContrast ?? this.brandDefaultContrast,
      brandHover: brandHover ?? this.brandHover,
      brandActive: brandActive ?? this.brandActive,
      brandStroke: brandStroke ?? this.brandStroke,
      brandFill: brandFill ?? this.brandFill,

      // Blue colors
      blueDefault: blueDefault ?? this.blueDefault,
      blueHover: blueHover ?? this.blueHover,
      blueActive: blueActive ?? this.blueActive,
      blueStroke: blueStroke ?? this.blueStroke,
      blueFill: blueFill ?? this.blueFill,

      // Green colors
      greenDefault: greenDefault ?? this.greenDefault,
      greenHover: greenHover ?? this.greenHover,
      greenActive: greenActive ?? this.greenActive,
      greenStroke: greenStroke ?? this.greenStroke,
      greenFill: greenFill ?? this.greenFill,

      // Gray colors
      grayPrimary: grayPrimary ?? this.grayPrimary,
      graySecondary: graySecondary ?? this.graySecondary,
      grayTertiary: grayTertiary ?? this.grayTertiary,
      grayQuaternary: grayQuaternary ?? this.grayQuaternary,

      // Yellow colors
      yellowDefault: yellowDefault ?? this.yellowDefault,
      yellowHover: yellowHover ?? this.yellowHover,
      yellowActive: yellowActive ?? this.yellowActive,
      yellowStroke: yellowStroke ?? this.yellowStroke,
      yellowFill: yellowFill ?? this.yellowFill,

      // Orange colors
      orangeDefault: orangeDefault ?? this.orangeDefault,
      orangeHover: orangeHover ?? this.orangeHover,
      orangeActive: orangeActive ?? this.orangeActive,
      orangeStroke: orangeStroke ?? this.orangeStroke,
      orangeFill: orangeFill ?? this.orangeFill,

      // Red colors
      redDefault: redDefault ?? this.redDefault,
      redHover: redHover ?? this.redHover,
      redActive: redActive ?? this.redActive,
      redStroke: redStroke ?? this.redStroke,
      redFill: redFill ?? this.redFill,

      // Pink colors
      pinkDefault: pinkDefault ?? this.pinkDefault,
      pinkHover: pinkHover ?? this.pinkHover,
      pinkActive: pinkActive ?? this.pinkActive,
      pinkStroke: pinkStroke ?? this.pinkStroke,
      pinkFill: pinkFill ?? this.pinkFill,

      // Background colors
      bgB0: bgB0 ?? this.bgB0,
      bgB1: bgB1 ?? this.bgB1,
      bgB2: bgB2 ?? this.bgB2,
      bgB3: bgB3 ?? this.bgB3,

      // Surface colors
      surface: surface ?? this.surface,
      surfaceCard: surfaceCard ?? this.surfaceCard,

      // Button/Interactive colors
      inactiveButton: inactiveButton ?? this.inactiveButton,
      activeButton: activeButton ?? this.activeButton,
      buttonTertiary: buttonTertiary ?? this.buttonTertiary,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,

      // Icon colors
      iconRed: iconRed ?? this.iconRed,
      iconBlue: iconBlue ?? this.iconBlue,
      textHighlightBlue: textHighlightBlue ?? this.textHighlightBlue,

      //Miscellaneous colors
      contrastBlack: contrastBlack ?? this.contrastBlack,
      contrastWhite: contrastWhite ?? this.contrastWhite,
      strokeSecondary: strokeSecondary ?? this.strokeSecondary,
    );
  }

  @override
  ThemeExtension<AppColorExtension> lerp(
    covariant ThemeExtension<AppColorExtension>? other,
    double t,
  ) {
    if (other is! AppColorExtension) {
      return this;
    }

    return AppColorExtension(
      // Text colors
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textQuaternary: Color.lerp(textQuaternary, other.textQuaternary, t)!,
      textWhite: Color.lerp(textWhite, other.textWhite, t)!,

      // Constant/Brand colors
      constantDefault: Color.lerp(constantDefault, other.constantDefault, t)!,
      constantDefaultBorder: Color.lerp(constantDefaultBorder, other.constantDefaultBorder, t)!,
      brandDefault: Color.lerp(brandDefault, other.brandDefault, t)!,
      brandContrast: Color.lerp(brandContrast, other.brandContrast, t)!,
      brandDefaultContrast: Color.lerp(brandDefaultContrast, other.brandDefaultContrast, t)!,
      brandHover: Color.lerp(brandHover, other.brandHover, t)!,
      brandActive: Color.lerp(brandActive, other.brandActive, t)!,
      brandStroke: Color.lerp(brandStroke, other.brandStroke, t)!,
      brandFill: Color.lerp(brandFill, other.brandFill, t)!,

      // Blue colors
      blueDefault: Color.lerp(blueDefault, other.blueDefault, t)!,
      blueHover: Color.lerp(blueHover, other.blueHover, t)!,
      blueActive: Color.lerp(blueActive, other.blueActive, t)!,
      blueStroke: Color.lerp(blueStroke, other.blueStroke, t)!,
      blueFill: Color.lerp(blueFill, other.blueFill, t)!,

      // Green colors
      greenDefault: Color.lerp(greenDefault, other.greenDefault, t)!,
      greenHover: Color.lerp(greenHover, other.greenHover, t)!,
      greenActive: Color.lerp(greenActive, other.greenActive, t)!,
      greenStroke: Color.lerp(greenStroke, other.greenStroke, t)!,
      greenFill: Color.lerp(greenFill, other.greenFill, t)!,

      // Gray colors
      grayPrimary: Color.lerp(grayPrimary, other.grayPrimary, t)!,
      graySecondary: Color.lerp(graySecondary, other.graySecondary, t)!,
      grayTertiary: Color.lerp(grayTertiary, other.grayTertiary, t)!,
      grayQuaternary: Color.lerp(grayQuaternary, other.grayQuaternary, t)!,

      // Yellow colors
      yellowDefault: Color.lerp(yellowDefault, other.yellowDefault, t)!,
      yellowHover: Color.lerp(yellowHover, other.yellowHover, t)!,
      yellowActive: Color.lerp(yellowActive, other.yellowActive, t)!,
      yellowStroke: Color.lerp(yellowStroke, other.yellowStroke, t)!,
      yellowFill: Color.lerp(yellowFill, other.yellowFill, t)!,

      // Orange colors
      orangeDefault: Color.lerp(orangeDefault, other.orangeDefault, t)!,
      orangeHover: Color.lerp(orangeHover, other.orangeHover, t)!,
      orangeActive: Color.lerp(orangeActive, other.orangeActive, t)!,
      orangeStroke: Color.lerp(orangeStroke, other.orangeStroke, t)!,
      orangeFill: Color.lerp(orangeFill, other.orangeFill, t)!,

      // Red colors
      redDefault: Color.lerp(redDefault, other.redDefault, t)!,
      redHover: Color.lerp(redHover, other.redHover, t)!,
      redActive: Color.lerp(redActive, other.redActive, t)!,
      redStroke: Color.lerp(redStroke, other.redStroke, t)!,
      redFill: Color.lerp(redFill, other.redFill, t)!,

      // Pink colors
      pinkDefault: Color.lerp(pinkDefault, other.pinkDefault, t)!,
      pinkHover: Color.lerp(pinkHover, other.pinkHover, t)!,
      pinkActive: Color.lerp(pinkActive, other.pinkActive, t)!,
      pinkStroke: Color.lerp(pinkStroke, other.pinkStroke, t)!,
      pinkFill: Color.lerp(pinkFill, other.pinkFill, t)!,

      // Background colors
      bgB0: Color.lerp(bgB0, other.bgB0, t)!,
      bgB1: Color.lerp(bgB1, other.bgB1, t)!,
      bgB2: Color.lerp(bgB2, other.bgB2, t)!,
      bgB3: Color.lerp(bgB3, other.bgB3, t)!,

      // Surface colors
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,

      // Button/Interactive colors
      inactiveButton: Color.lerp(inactiveButton, other.inactiveButton, t)!,
      activeButton: Color.lerp(activeButton, other.activeButton, t)!,
      buttonTertiary: Color.lerp(buttonTertiary, other.buttonTertiary, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,

      // Icon colors
      iconRed: Color.lerp(iconRed, other.iconRed, t)!,
      iconBlue: Color.lerp(iconBlue, other.iconBlue, t)!,
      textHighlightBlue: Color.lerp(textHighlightBlue, other.textHighlightBlue, t)!,

      //Miscellaneous colors
      contrastBlack: Color.lerp(contrastBlack, other.contrastBlack, t)!,
      contrastWhite: Color.lerp(contrastWhite, other.contrastWhite, t)!,
      strokeSecondary: Color.lerp(strokeSecondary, other.strokeSecondary, t)!,
    );
  }
}

/// Extension to create a ColorScheme from AppColorExtension.
extension ColorSchemeBuilder on AppColorExtension {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: blueDefault,
      onPrimary: textWhite,
      secondary: greenDefault,
      onSecondary: textWhite,
      tertiary: yellowDefault,
      onTertiary: textPrimary,
      error: redDefault,
      onError: textWhite,
      surface: surface,
      onSurface: textPrimary,
      surfaceTint: blueDefault.withValues(alpha: 0.05),
    );
  }
}
