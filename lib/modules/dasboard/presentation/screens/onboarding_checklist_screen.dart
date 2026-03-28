import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/animated_progress_bar.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

import '../../../onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';

@RoutePage()
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
                    context.l10n.onboardingChecklist,
                    style: context.theme.fonts.heading2Bold.copyWith(
                        color: context.theme.colors.textPrimary,
                        fontFamily: 'HankenGrotesk'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      context.l10n.completeAllStepsToActivate,
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
                      title: context.l10n.createFreelancerAccount),
                  OnboardingCard(
                      onTap: () =>
                          context.router.push(const VerifyIdentityRoute()),
                      svgAsset: AppAssets.identityVerification,
                      title: context.l10n.verifyYourIdentity),
                  OnboardingCard(
                      onTap: () => context.router.push(const ProvideBvnRoute()),
                      svgAsset: AppAssets.bank,
                      title: context.l10n.provideYourBvn),
                  OnboardingCard(
                      onTap: () =>
                          context.router.push(const TaxInformationRoute()),
                      svgAsset: AppAssets.scales,
                      title: context.l10n.addTaxInfoForCompliance),
                  OnboardingCard(
                      onTap: () => context.router.push(const FundWalletRoute()),
                      svgAsset: AppAssets.wallet,
                      title: context.l10n.fundWalletWithTokens),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
