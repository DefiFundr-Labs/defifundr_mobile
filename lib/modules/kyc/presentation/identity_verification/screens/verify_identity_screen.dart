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
                  Text('Verify Your Identity',
                      style: context.theme.fonts.heading2Bold.copyWith(
                          color: context.theme.colors.textPrimary,
                          fontFamily: 'HankenGrotesk')),
                  const SizedBox(height: 8),
                  Text(
                      'We\'ll use this info to confirm your identity and comply with our legal requirements.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary)),
                  const SizedBox(height: 20),
                  InfoCard(
                    svgAsset: AppAssets.identityVerification,
                    title: 'Your ID',
                    description: 'We accept most common forms of ID.',
                    onTap: () {},
                  ),
                  InfoCard(
                    svgAsset: AppAssets.userFocus,
                    title: 'A quick scan of your face',
                    description: 'This is to confirm that you match your ID.',
                    onTap: () {
                      print('Tapped on Face scan info');
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: BrandButton(
              text: "Get started",
              onPressed: () =>
                  context.pushNamed(RouteConstants.selectIdCountry),
            ),
          ),
        ],
      ),
    );
  }
}
