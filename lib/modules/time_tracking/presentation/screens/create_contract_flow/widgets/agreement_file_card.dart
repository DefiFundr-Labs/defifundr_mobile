import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgreementFileCard extends StatelessWidget {
  final VoidCallback? onView;
  final bool isSmall;

  const AgreementFileCard({
    super.key,
    this.onView,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined,
              color: context.theme.colors.brandDefault, size: 22),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Standard Agreement',
              style: isSmall
                  ? context.theme.fonts.textSmMedium
                  : context.theme.fonts.textMdMedium,
            ),
          ),
          if (onView != null)
            GestureDetector(
              onTap: onView,
              child: Text(
                'View',
                style: context.theme.fonts.textSmSemiBold.copyWith(
                  color: context.theme.colors.brandDefault,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
