import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerificationConfirmedScreen extends StatefulWidget {
  const VerificationConfirmedScreen({super.key});

  @override
  State<VerificationConfirmedScreen> createState() =>
      _VerificationConfirmedScreenState();
}

class _VerificationConfirmedScreenState
    extends State<VerificationConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.verificationProgressSvg,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Verification In Progress',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'HankenGrotesk',
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your identity is currently being verified. You\'ll receive an update via email within a few minutes.',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 20 / 14,
                          letterSpacing: 0,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BrandButton(
                text: "Back to checklist",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
