import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// PIN Dot Component
class PinDot extends StatelessWidget {
  final bool isFilled;
  final bool hasError;

  const PinDot({
    super.key,
    required this.isFilled,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: hasError
              ? context.theme.colors.redActive
              : isFilled
                  ? context.theme.colors.brandDefault
                  : context.theme.colors.grayTertiary,
          width: 1.5,
        ),
      ),
      child: isFilled
          ? Center(
              child: Container(
                width: 16.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: hasError
                      ? context.theme.colors.redActive
                      : context.theme.colors.brandDefault,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
