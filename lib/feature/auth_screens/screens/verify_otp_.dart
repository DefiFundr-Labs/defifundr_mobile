import 'package:flutter/material.dart';

import '../../../core/constants/app_texts.dart';
import '../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../../../core/shared/buttons/primary_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colors.bgB0,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colors.bgB0,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: Theme.of(context).colors.textPrimary)),
            child: Row(
              spacing: 4,
              children: [
                Icon(Icons.headphones_outlined, size: 16, applyTextScaling: true, color: Theme.of(context).colors.textPrimary),
                Text(AppTexts.needHelp, style: Theme.of(context).fonts.textSmMedium)
              ],
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppTexts.verifyOTP, style: Theme.of(context).fonts.heading2Bold),
            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: AppTexts.verifyOTPDesc,
                style: Theme.of(context).fonts.textMdRegular,
                children: [
                  TextSpan(
                    text: '\ttempuser12346@mail.com',
                    style: Theme.of(context).fonts.textMdSemiBold.copyWith(color: Theme.of(context).colors.brandDefaultContrast),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(AppTexts.enterCode, style: Theme.of(context).fonts.textMdMedium),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
                SizedBox(
                  height: 52,
                  width: 52,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).fonts.heading1Regular,
                    maxLines: 1,
                    decoration: InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colors.strokeSecondary),
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colors.bgB1,
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.info,
                    size: 20,
                    applyTextScaling: true,
                    color: Theme.of(context).colors.graySecondary,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppTexts.cantFindCode, style: Theme.of(context).fonts.textMdSemiBold),
                      Text(AppTexts.cantFindCodeDesc, style: Theme.of(context).fonts.textSmRegular),
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            AppButton(
              text: AppTexts.resetPassword,
              textColor: Theme.of(context).colors.contrastWhite,
              color: Theme.of(context).colors.contrastBlack,
              onTap: () {},
            ),
            AppButton(
              text: AppTexts.resetPassword,
              textColor: Theme.of(context).colors.contrastWhite,
              color: Theme.of(context).colors.contrastBlack,
              onTap: () {},
            ),
            if (MediaQuery.viewInsetsOf(context).bottom < 10) SizedBox(height: 8 + MediaQuery.systemGestureInsetsOf(context).bottom)
          ],
        ),
      ),
    );
  }
}
