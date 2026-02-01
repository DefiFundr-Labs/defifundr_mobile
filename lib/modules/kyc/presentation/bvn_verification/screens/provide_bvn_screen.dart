import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/bvn_verification/widgets/information_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProvideBvnScreen extends StatelessWidget {
  const ProvideBvnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
                  Text('Provide Your BVN',
                      style: context.theme.fonts.heading2Bold.copyWith(
                          color: context.theme.colors.textPrimary,
                          fontFamily: 'HankenGrotesk')),
                  const SizedBox(height: 8),
                  Text(
                      'We need your BVN to help you get a fiat account ready for use.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary)),
                  const SizedBox(height: 20),
                  InformationCard(title: "We will only have access to your:"),
                  SizedBox(height: 20),
                  AppTextField(
                    controller: controller,
                    labelText: 'BVN',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          PrimaryButton(
            text: "Confirm",
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
