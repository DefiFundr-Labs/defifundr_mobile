import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinInput extends StatelessWidget {
  final List<String> pinValues;
  final int pinLength;
  final int activeIndex;
  final bool hasError;

  const PinInput({
    super.key,
    required this.pinValues,
    this.pinLength = 6,
    required this.activeIndex,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pinLength,
        (index) => Container(
          width: 52.w,
          height: 52.w,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFFEEEFF2) // Light mode color
                : context.theme.colors.bgB1,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: hasError
                  ? colors.redDefault
                  : (index == activeIndex
                      ? colors.blueDefault
                      : colors.grayQuaternary),
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            index < pinValues.length ? pinValues[index] : '',
            style: fonts.heading2Bold.copyWith(
              fontSize: 32,
              color: hasError
                  ? colors.redDefault
                  : Theme.of(context).brightness == Brightness.light
                      ? colors.textPrimary // Light mode color
                      : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
