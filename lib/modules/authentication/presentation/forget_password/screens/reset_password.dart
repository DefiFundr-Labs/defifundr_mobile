import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart'
    show AppColors;
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_texts.dart';
import '../../../../../core/shared/common/appbar/appbar.dart';
import '../bloc/forgot_password_bloc.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.resetPassword,
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 24.sp,
                  color: context.theme.colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.l10n.enterYourEmailAddressToGetACodeToResetYourPassword,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: context.theme.colors.textSecondary,
                ),
              ),
              VerticalMargin(20),
              AppTextField(
                labelText: AppTexts.emailAddress,
                controller: _emailController,
              ),
              Spacer(),
              PrimaryButton(
                text: AppTexts.sendCode,
                textColor: AppColors.white100,
                onPressed: () {
                  // Store email in bloc state before navigating
                  context.read<ForgotPasswordBloc>().add(
                        SubmitEmail(_emailController.text.trim()),
                      );
                  // Navigate to OTP verification screen
                  context.router.push(const VerifyOtpRoute());
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
