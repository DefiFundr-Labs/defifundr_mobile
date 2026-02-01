import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class VerificationInProgressScreen extends StatefulWidget {
  const VerificationInProgressScreen({super.key});

  @override
  State<VerificationInProgressScreen> createState() =>
      _VerificationInProgressScreenState();
}

class _VerificationInProgressScreenState
    extends State<VerificationInProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    resolveSvg(
                      context: context,
                      lightSvg: AppAssets.verificationProgressSvg,
                      darkSvg: AppAssets.verificationProgressSvgDark,
                    ),
                    const SizedBox(height: 40),
                    Text('Verification In Progress',
                        style: context.theme.fonts.heading2Bold.copyWith(
                            color: context.theme.colors.textPrimary,
                            fontFamily: 'HankenGrotesk')),
                    const SizedBox(height: 12),
                    Text(
                      'Your identity is currently being verified. You\'ll receive an update via email within a few minutes.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: BrandButton(
              text: "Back to checklist",
              onPressed: () =>
                  context.router.push(const OnboardingChecklistRoute()),
            ),
          ),
        ],
      ),
    );
  }
}
