import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsSectionCard extends StatelessWidget {
  final String title;
  final VoidCallback? onEdit;
  final List<Widget> children;

  const PersonalDetailsSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Text(
                  title,
                  style: fonts.textBaseSemiBold.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (onEdit != null)
                  GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: isLightMode ? colors.bgB1 : colors.bgB2,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: colors.bgB2,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: fonts.textSmMedium.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: colors.bgB2),
          ...children,
        ],
      ),
    );
  }
}
