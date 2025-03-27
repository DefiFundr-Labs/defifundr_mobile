import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/auth_header.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

final defaultPinTheme = PinTheme(
  width: 44,
  height: 44,
  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.textHintColor, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                  title: AppTexts.verifyOtp,
                  subtitle: AppTexts.enterOtpCode,
                ),
                Text(
                  'test@defifundr.com',
                  style: Config.b3(context).copyWith(
                    color: AppColors.black200,
                  ),
                ),
                VerticalMargin(0.08.sh),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  disabledPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: Color(0xffA6B7D4),
                    ),
                  ),
                ),
                VerticalMargin(0.12.sh),
                Center(
                  child: Text(
                    AppTexts.resendCode,
                    textAlign: TextAlign.center,
                  ),
                ),
                AppButton(
                    text: AppTexts.confirmOtp,
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
