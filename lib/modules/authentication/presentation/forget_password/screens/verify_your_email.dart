import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyYourEmail extends StatefulWidget {
  const VerifyYourEmail({super.key});

  @override
  State<VerifyYourEmail> createState() => _VerifyYourEmailState();
}

class _VerifyYourEmailState extends State<VerifyYourEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              width: 111.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: context.theme.appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: context.theme.primaryColorDark,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Need Help?',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.theme.primaryColorDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Your Email',
              style: context.theme.textTheme.headlineLarge?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                text: 'Please enter the 6 digit OTP code sent to ',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.theme.disabledColor,
                ),
                children: [
                  TextSpan(
                    text: 'pogot42210@nokdot.com',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Enter Code',
              style: context.theme.textTheme.headlineMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              animationType: AnimationType.none,
              textStyle: context.theme.textTheme.headlineMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: context.theme.primaryColorDark,
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeBorderWidth: 1,
                inactiveBorderWidth: 1,
                selectedBorderWidth: 1,
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
                selectedColor: Colors.grey,
                activeFillColor: Colors.grey,
                inactiveFillColor: Colors.grey,
                selectedFillColor: Colors.grey,
              ),
              onChanged: (value) {
                print('Entered code: $value');
              },
              onCompleted: (value) {
                print('Code completed: $value');
              },
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              height: 76.h,
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outlined,
                            color: context.theme.primaryColorDark),
                        SizedBox(width: 8.w),
                        Text(
                          'Can’t find code sent?',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Try checking your junk/spam folder, or resend the code.',
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Text(
                  'Verify code',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.theme.scaffoldBackgroundColor),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resend code',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
