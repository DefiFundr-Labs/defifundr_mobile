import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Bottom Actions Component
class BottomActions extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onForgotPin;

  const BottomActions({
    super.key,
    required this.onLogout,
    required this.onForgotPin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onLogout,
          child: Text(
            'Log out',
            style: context.theme.fonts.bodyMedium.copyWith(
              color: context.theme.colors.brandDefault,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: onForgotPin,
          child: Text(
            'Forgot your PIN?',
            style: context.theme.fonts.bodyMedium.copyWith(
              color: context.theme.colors.brandDefault,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
