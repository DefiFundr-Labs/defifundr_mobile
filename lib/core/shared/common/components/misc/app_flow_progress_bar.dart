import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A thin horizontal step-progress bar for multi-step onboarding/flow screens.
///
/// Renders a full-width track with a colored fill representing progress.
/// The fill width is calculated as `currentStep / totalSteps * 100%`.
///
/// ```dart
/// // Step 3 of 5
/// AppFlowProgressBar(currentStep: 3, totalSteps: 5)
///
/// // 60 % complete — explicit fraction
/// AppFlowProgressBar(currentStep: 3, totalSteps: 5, height: 6)
///
/// // Custom track/fill colors
/// AppFlowProgressBar(
///   currentStep: 2,
///   totalSteps: 4,
///   trackColor: Colors.grey[200],
///   fillColor: context.theme.colors.brandDefault,
/// )
/// ```
class AppFlowProgressBar extends StatelessWidget {
  const AppFlowProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.height = 4,
    this.trackColor,
    this.fillColor,
  })  : assert(currentStep >= 0, 'currentStep must be >= 0'),
        assert(totalSteps > 0, 'totalSteps must be > 0'),
        assert(currentStep <= totalSteps, 'currentStep must be <= totalSteps');

  /// The completed step count (0-based index is fine; pass `currentStep + 1`
  /// for 1-based counting).
  final int currentStep;

  /// Total number of steps in the flow.
  final int totalSteps;

  /// Bar height in dp. Defaults to `4`.
  final double height;

  /// Color of the unfilled track. Defaults to `Colors.grey[200]`.
  final Color? trackColor;

  /// Color of the filled portion.
  /// Defaults to `context.theme.colors.brandDefault`.
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final progress = (currentStep / totalSteps).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height.h,
          width: double.infinity,
          color: trackColor ?? Colors.grey[200],
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: height.h,
              decoration: BoxDecoration(
                color: fillColor ?? colors.brandDefault,
                borderRadius: BorderRadius.circular(height.r),
              ),
            ),
          ),
        );
      },
    );
  }
}
