import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgreementFileCard extends StatelessWidget {
  final VoidCallback? onView;

  const AgreementFileCard({
    super.key,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.description_outlined,
            color: context.theme.colors.brandDefault, size: 22),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Standard Agreement',
            style: context.theme.fonts.textMdMedium,
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
    );
  }
}
