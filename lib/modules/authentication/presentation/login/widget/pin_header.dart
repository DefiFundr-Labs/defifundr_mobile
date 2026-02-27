import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinLoginHeader extends StatelessWidget {
  final String userName;

  const PinLoginHeader({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarHeaderWidget(),
        SizedBox(height: 32.h),
        Text(
          '${context.l10n.welcomeBack}, $userName',
          style: context.theme.fonts.bodyMedium.copyWith(
            fontSize: 24.sp,
            color: context.theme.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          context.l10n.pleaseEnterYourPinToAccessYourAccount,
          style: context.theme.fonts.bodyMedium.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: context.theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
