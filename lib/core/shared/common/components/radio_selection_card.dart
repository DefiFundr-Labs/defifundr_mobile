import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioSelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle? titleStyle;

  const RadioSelectionCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB0,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? context.theme.colors.brandDefault
                : Colors.transparent,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: context.theme.colors.textPrimary.withOpacity(0.05),
                blurRadius: 1,
                spreadRadius: -5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        context.theme.fonts.textBaseSemiBold.copyWith(
                          color: context.theme.colors.textPrimary,
                        ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle!,
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _RadioDot(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool isSelected;
  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.sp,
      height: 20.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? context.theme.colors.brandDefault
              : context.theme.colors.strokeSecondary,
          width: isSelected ? 5.sp : 1.sp,
        ),
        color: Colors.white,
      ),
    );
  }
}
