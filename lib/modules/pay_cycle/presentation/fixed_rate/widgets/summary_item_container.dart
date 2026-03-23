import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryItemContainer extends StatelessWidget {
  final String label;
  final String value;
  final bool isBoldValue;

  const SummaryItemContainer({
    Key? key,
    required this.label,
    required this.value,
    this.isBoldValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          Text(
            value,
            style: isBoldValue
                ? context.theme.fonts.textMdSemiBold.copyWith(
                    color: context.theme.colors.textPrimary,
                  )
                : context.theme.fonts.textMdMedium.copyWith(
                    color: context.theme.colors.textPrimary,
                  ),
          ),
        ],
      ),
    );
  }
}
