import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/keyboard/pin_dots_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinInputSection extends StatelessWidget {
  final int pinLength;
  final int currentPinLength;
  final bool showError;
  final String errorMessage;
  final Animation<double> shakeAnimation;
  final double dotSize;
  final double spacing;

  const PinInputSection({
    super.key,
    required this.pinLength,
    required this.currentPinLength,
    required this.showError,
    required this.errorMessage,
    required this.shakeAnimation,
    this.dotSize = 64,
    this.spacing = 26,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter PIN',
          style: context.theme.fonts.bodyMedium.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: context.theme.colors.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        PinDotsRow(
          pinLength: pinLength,
          currentPinLength: currentPinLength,
          hasError: showError,
          shakeAnimation: shakeAnimation,
          dotSize: dotSize,
          spacing: spacing,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: showError
              ? Padding(
                  key: const ValueKey('error'),
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    errorMessage,
                    style: context.theme.fonts.textSmMedium.copyWith(
                      color: context.theme.colors.redDefault,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              : SizedBox(
                  key: const ValueKey('no-error'),
                  height: 8.h,
                ),
        ),
      ],
    );
  }
}
