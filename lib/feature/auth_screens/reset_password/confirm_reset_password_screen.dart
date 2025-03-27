import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class ConfirmResetPasswordScreen extends StatefulWidget {
  const ConfirmResetPasswordScreen({super.key});

  @override
  State<ConfirmResetPasswordScreen> createState() =>
      _ConfirmResetPasswordScreenState();
}

class _ConfirmResetPasswordScreenState
    extends State<ConfirmResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: true,
          title: '',
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppTexts.passwordReset,
                      style: Config.h2(context).copyWith(
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      AppTexts.passwordResetSuccessfully,
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      ),
                    ),
                  ],
                ),
                Image.asset(AppIcons.people),
                AppButton(
                    text: AppTexts.continuee,
                    color: AppColors.primaryColor,
                    textColor: AppColors.white100,
                    onTap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
