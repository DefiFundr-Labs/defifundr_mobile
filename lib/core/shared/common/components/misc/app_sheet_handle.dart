import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The drag-handle pill shown at the top of modal bottom sheets.
///
/// Place as the first child in the sheet's `Column`, above any content.
/// Handles its own top padding so the sheet body does not need extra spacing.
///
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (_) => Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       const AppSheetHandle(),
///       // ... sheet content
///     ],
///   ),
/// );
/// ```
class AppSheetHandle extends StatelessWidget {
  const AppSheetHandle({
    super.key,
    this.width = 40,
    this.height = 4,
    this.topPadding = 12,
    this.bottomPadding = 8,
    this.color,
  });

  /// Width of the pill in dp. Defaults to `40`.
  final double width;

  /// Height (thickness) of the pill in dp. Defaults to `4`.
  final double height;

  /// Space above the pill. Defaults to `12`.
  final double topPadding;

  /// Space below the pill. Defaults to `8`.
  final double bottomPadding;

  /// Pill color. Defaults to `context.theme.colors.strokePrimary`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Padding(
      padding: EdgeInsets.only(top: topPadding.h, bottom: bottomPadding.h),
      child: Center(
        child: Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            color: color ?? colors.strokePrimary,
            borderRadius: BorderRadius.circular(height.r),
          ),
        ),
      ),
    );
  }
}
