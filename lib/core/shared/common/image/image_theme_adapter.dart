import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that automatically adapts images and SVGs based on the current theme
class ThemeAdaptiveImage extends StatelessWidget {
  /// Asset path for light theme image/SVG
  final String? lightAsset;

  /// Asset path for dark theme image/SVG
  final String? darkAsset;

  /// Single asset path (will use color adaptation for SVGs)
  final String? asset;

  /// Width of the image/SVG
  final double? width;

  /// Height of the image/SVG
  final double? height;

  /// Fit behavior for the image/SVG
  final BoxFit? fit;

  /// Color for light theme (SVG only)
  final Color? lightColor;

  /// Color for dark theme (SVG only)
  final Color? darkColor;

  /// Whether to use theme colors automatically for SVGs
  final bool useThemeColors;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Placeholder widget while loading
  final Widget? placeholder;

  /// Error widget if image fails to load
  final Widget? errorWidget;

  const ThemeAdaptiveImage({
    Key? key,
    this.lightAsset,
    this.darkAsset,
    this.asset,
    this.width,
    this.height,
    this.fit,
    this.lightColor,
    this.darkColor,
    this.useThemeColors = true,
    this.semanticsLabel,
    this.placeholder,
    this.errorWidget,
  })  : assert(
          (lightAsset != null && darkAsset != null) || asset != null,
          'Either provide both lightAsset and darkAsset, or a single asset',
        ),
        super(key: key);

  /// Constructor for different assets per theme
  const ThemeAdaptiveImage.assets({
    Key? key,
    required String lightAsset,
    required String darkAsset,
    this.width,
    this.height,
    this.fit,
    this.semanticsLabel,
    this.placeholder,
    this.errorWidget,
  })  : lightAsset = lightAsset,
        darkAsset = darkAsset,
        asset = null,
        lightColor = null,
        darkColor = null,
        useThemeColors = false,
        super(key: key);

  /// Constructor for single asset with color adaptation (SVG only)
  const ThemeAdaptiveImage.colorAdaptive({
    Key? key,
    required String asset,
    this.width,
    this.height,
    this.fit,
    Color? lightColor,
    Color? darkColor,
    this.useThemeColors = true,
    this.semanticsLabel,
    this.placeholder,
    this.errorWidget,
  })  : asset = asset,
        lightAsset = null,
        darkAsset = null,
        lightColor = lightColor,
        darkColor = darkColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    // Determine which asset to use
    String assetPath;
    if (lightAsset != null && darkAsset != null) {
      assetPath = isDarkMode ? darkAsset! : lightAsset!;
    } else {
      assetPath = asset!;
    }

    // Check if it's an SVG file
    final isSvg = assetPath.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return _buildSvg(context, assetPath, isDarkMode, theme);
    } else {
      return _buildImage(context, assetPath);
    }
  }

  Widget _buildSvg(BuildContext context, String assetPath, bool isDarkMode,
      ThemeData theme) {
    Color? svgColor;

    // Determine SVG color
    if (lightColor != null && darkColor != null) {
      svgColor = isDarkMode ? darkColor : lightColor;
    } else if (useThemeColors) {
      svgColor = isDarkMode
          ? theme.colorScheme.onSurface
          : theme.colorScheme.onSurface;
    }

    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter:
          svgColor != null ? ColorFilter.mode(svgColor, BlendMode.srcIn) : null,
      semanticsLabel: semanticsLabel,
      placeholderBuilder:
          placeholder != null ? (context) => placeholder! : null,
    );
  }

  Widget _buildImage(BuildContext context, String assetPath) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticsLabel,
      frameBuilder: placeholder != null
          ? (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                return child;
              }
              return placeholder!;
            }
          : null,
      errorBuilder: errorWidget != null
          ? (context, error, stackTrace) => errorWidget!
          : null,
    );
  }
}

/// Extension to make theme detection easier
extension ThemeAdaptiveImageExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// Helper class for managing theme-adaptive image assets
class ThemeImageAssets {
  final String light;
  final String dark;

  const ThemeImageAssets({
    required this.light,
    required this.dark,
  });

  String getAsset(BuildContext context) {
    return context.isDarkMode ? dark : light;
  }
}

// Usage examples:

// 1. Different images for light/dark themes:
// ThemeAdaptiveImage.assets(
//   lightAsset: 'assets/logo_light.png',
//   darkAsset: 'assets/logo_dark.png',
//   width: 200,
//   height: 100,
// )

// 2. Single SVG with automatic theme color adaptation:
// ThemeAdaptiveImage.colorAdaptive(
//   asset: 'assets/icon.svg',
//   width: 24,
//   height: 24,
//   useThemeColors: true,
// )

// 3. Single SVG with custom colors for each theme:
// ThemeAdaptiveImage.colorAdaptive(
//   asset: 'assets/icon.svg',
//   width: 24,
//   height: 24,
//   lightColor: Colors.blue,
//   darkColor: Colors.lightBlue,
// )

// 4. Using helper class for asset management:
// const logoAssets = ThemeImageAssets(
//   light: 'assets/logo_light.png',
//   dark: 'assets/logo_dark.png',
// );
// 
// Image.asset(logoAssets.getAsset(context))