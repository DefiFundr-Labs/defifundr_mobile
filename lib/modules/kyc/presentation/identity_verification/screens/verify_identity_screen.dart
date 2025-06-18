import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/info_card.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerifyIdentityScreen extends StatefulWidget {
  const VerifyIdentityScreen({super.key});

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: context.theme.scaffoldBackgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomBackButton(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Verify Your Identity',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'HankenGrotesk',
                        fontWeight: FontWeight.w700,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textPrimary,
                          darkColor: AppColorDark.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We\'ll use this info to confirm your identity and comply with our legal requirements.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textSecondary,
                          darkColor: AppColorDark.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      svgAsset: AppAssets.identityVerification,
                      title: 'Your ID',
                      description: 'We accept most common forms of ID.',
                      onTap: () {
                        context.pushNamed(RouteConstants.selectIdCountry);
                      },
                    ),
                    const SizedBox(height: 16),
                    InfoCard(
                      svgAsset: AppAssets.userFocus,
                      title: 'A quick scan of your face',
                      description: 'This is to confirm that you match your ID.',
                      onTap: () {
                        print('Tapped on Face scan info');
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BrandButton(
                text: "Get started",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
