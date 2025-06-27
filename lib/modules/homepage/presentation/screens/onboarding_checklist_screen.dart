import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/homepage/presentation/widgets/animated_progress_bar.dart';
import 'package:defifundr_mobile/modules/homepage/presentation/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';

class OnboardingChecklistScreen extends StatefulWidget {
  const OnboardingChecklistScreen({super.key});

  @override
  State<OnboardingChecklistScreen> createState() =>
      _OnboardingChecklistScreenState();
}

class _OnboardingChecklistScreenState extends State<OnboardingChecklistScreen> {
  double _progressValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: CustomBackButton(),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Onboarding Checklist',
                    style: context.theme.fonts.heading2Bold.copyWith(
                        color: context.theme.colors.textPrimary,
                        fontFamily: 'HankenGrotesk'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'You must complete all steps to fully activate your account.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("${_progressValue.round()}%",
                          style: context.theme.fonts.textBaseSemiBold),
                      SizedBox(width: 10.h),
                      Expanded(
                          child: AnimatedProgressBar(
                        progress: 0.2,
                        showPercentage: false,
                        topColor: context.theme.colors.brandDefault,
                        backgroundColor:
                            context.theme.colors.graySecondary.withAlpha(60),
                        height: 6.sp,
                      )),
                    ],
                  ),
                  SizedBox(height: 20),
                  OnboardingCard(
                      isDone: true,
                      svgAsset: AppAssets.userCircleDashed,
                      title: "Create freelancer account"),
                  OnboardingCard(
                      onTap: () =>
                          context.pushNamed(RouteConstants.verifyIdentity),
                      svgAsset: AppAssets.identityVerification,
                      title: "Verify your identity"),
                  OnboardingCard(
                      onTap: () =>
                          context.pushNamed(RouteConstants.provideBvnScreen),
                      svgAsset: AppAssets.bank,
                      title: "Provide your BVN"),
                  OnboardingCard(
                      onTap: () => context
                          .pushNamed(RouteConstants.taxInformationScreen),
                      svgAsset: AppAssets.scales,
                      title: "Add tax info for compliance"),
                  OnboardingCard(
                      svgAsset: AppAssets.wallet,
                      title: "Fund wallet with tokens"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
