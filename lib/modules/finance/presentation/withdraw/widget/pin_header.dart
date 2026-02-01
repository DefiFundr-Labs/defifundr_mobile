import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPinHeader extends StatelessWidget {
  const ConfirmPinHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarHeaderWidget(
          widget: IconButton(
            onPressed: () {
              context.router.maybePop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          'Enter Your PIN Code',
          style: context.theme.fonts.bodyMedium.copyWith(
            fontSize: 24.sp,
            color: context.theme.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Enter your 4 digit PIN code to complete this transaction',
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
