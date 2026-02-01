import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/info_card.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
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
                      )),
                  SizedBox(height: 20.h),
                  Text(
                      'We\'ll use this info to confirm your identity and comply with our legal requirements.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary)),
                  SizedBox(height: 20.h),
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
          PrimaryButton(
            text: "Get started",
            onPressed: () {
              context.router.push(const ProcessingBvnRequestRoute());
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
