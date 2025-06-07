import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/select_country_info.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/user_info_safe.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                      'Select country where your ID document was issued',
                      style: TextStyle(
                        fontSize: 20,
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
                    SelectCountryInfo(
                      svgAsset: AppAssets.nigeriaSvg,
                      svgHasColor: false,
                      title: 'Nigeria',
                      onTap: () {
                        context.pushNamed(RouteConstants.verificationConfirmed);
                      },
                    ),
                    const SizedBox(height: 12 * 2),
                    Text(
                      'Select your document type',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'HankenGrotesk',
                        fontWeight: FontWeight.w700,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textPrimary,
                          darkColor: AppColorDark.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12 * 2),
                    SelectCountryInfo(
                      svgAsset: AppAssets.carProfile,
                      title: 'Driver License',
                    ),
                    const SizedBox(height: 16),
                    SelectCountryInfo(
                      svgAsset: AppAssets.identityVerification,
                      title: 'Voter ID',
                    ),
                    const SizedBox(height: 16),
                    SelectCountryInfo(
                      svgAsset: AppAssets.globeSvg,
                      title: 'International passport',
                    ),
                    const SizedBox(height: 16),
                    SelectCountryInfo(
                      svgAsset: AppAssets.ninSvg,
                      title: 'NIN',
                    ),
                    const SizedBox(height: 8 * 4),
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
      ),
    );
  }
}
