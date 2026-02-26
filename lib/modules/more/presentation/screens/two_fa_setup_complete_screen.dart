import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class TwoFaSetupCompleteScreen extends StatelessWidget {
  const TwoFaSetupCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),
              _buildIcon(context),
              SizedBox(height: 32.h),
              Text(
                '2FA setup complete',
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24.sp,
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Two factor authentication is enabled, we'll use your authenticator app codes for transactions",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Back to settings',
                isEnabled: true,
                onPressed: () => context.router.popUntilRoot(),
              ),
              SizedBox(
                  height:
                      MediaQuery.systemGestureInsetsOf(context).bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colors = context.theme.colors;
    return Container(
      width: 96.w,
      height: 96.w,
      decoration: BoxDecoration(
        color: colors.brandFill,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          Assets.icons.shieldCheckered,
          width: 52.w,
          height: 52.w,
          colorFilter:
              ColorFilter.mode(colors.brandDefault, BlendMode.srcIn),
        ),
      ),
    );
  }
}
