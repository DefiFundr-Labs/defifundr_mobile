import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/select_country_info.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/user_info_safe.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SelectIdCountryScreen extends StatefulWidget {
  const SelectIdCountryScreen({super.key});

  @override
  State<SelectIdCountryScreen> createState() => _SelectIdCountryScreenState();
}

class _SelectIdCountryScreenState extends State<SelectIdCountryScreen> {
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
                  Text('Select country where your ID document was issued',
                      style: context.theme.fonts.heading3Bold.copyWith(
                          fontFamily: 'HankenGrotesk',
                          color: context.theme.colors.textPrimary)),
                  const SizedBox(height: 8),
                  SelectCountryInfo(
                    svgAsset: AppAssets.nigeriaSvg,
                    svgHasColor: false,
                    title: 'Nigeria',
                    onTap: () =>
                        context.router.push(const VerificationInProgressRoute()),
                  ),
                  const SizedBox(height: 24 - 16),
                  Text('Select your document type',
                      style: context.theme.fonts.heading3Bold.copyWith(
                          fontFamily: 'HankenGrotesk',
                          color: context.theme.colors.textPrimary)),
                  const SizedBox(height: 20),
                  SelectCountryInfo(
                    svgAsset: AppAssets.carProfile,
                    title: 'Driver license',
                  ),
                  SelectCountryInfo(
                    svgAsset: AppAssets.identityVerification,
                    title: 'Voter ID',
                  ),
                  SelectCountryInfo(
                    svgAsset: AppAssets.globeSvg,
                    title: 'International passport',
                  ),
                  SelectCountryInfo(
                    svgAsset: AppAssets.ninSvg,
                    title: 'NIN',
                  ),
                  const SizedBox(height: 24 - 16),
                  UserInfoSafeCard(
                    svgAsset: AppAssets.infoSvg,
                    title: "Your information is safe",
                    description:
                        "We only collect the necessary details to confirm your identity. "
                        "Your information is encrypted and never shared with third parties.",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
