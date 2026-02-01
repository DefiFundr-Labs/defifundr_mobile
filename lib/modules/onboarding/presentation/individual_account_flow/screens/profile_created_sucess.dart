import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/components/confetti_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProfileCreatedSucessScreen extends StatelessWidget {
  const ProfileCreatedSucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfettiWrapper(
      autoStart: true,
      duration: const Duration(seconds: 5),
      particleIntensity: 1000,
      shouldLoop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: _buildContent(context),
                  ),
                ),
                _buildActionButton(context),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSuccessIcon(context),
        SizedBox(height: 32.h),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildSuccessIcon(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: context.theme.colors.brandFill,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          Assets.icons.userCircleCheck,
          width: 40.w,
          height: 40.h,
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Profile has been created!',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineLarge?.copyWith(
            fontSize: 24.sp,
            color: context.theme.colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Your PIN has been successfully created. You can now use this PIN to log in to your account securely.',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: context.theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return PrimaryButton(
      text: 'Proceed to login',
      isEnabled: true,
      onPressed: () {
        context.router.push(LoginRoute());
      },
    );
  }
}
