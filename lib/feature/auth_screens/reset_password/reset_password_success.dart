import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 123),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppTexts.passwordReset,
                style: Config.h2(context).copyWith(fontSize: 26),
              ),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Text(
                  textAlign: TextAlign.center,
                  AppTexts.passwordhasbeenresetsuccessfully,
                  style: Config.h2(context).copyWith(fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 129),
            SvgPicture.asset(AppAssets.groupIcon),
            SizedBox(height: 141),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AppButton(
                text: "Continue",
                textColor: AppColors.white100,
                color: AppColors.primaryColor,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
