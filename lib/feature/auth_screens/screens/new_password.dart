import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_texts.dart';
import '../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../../../core/shared/buttons/primary_button.dart';
import '../../../core/shared/textfield/app_text_field.dart';
import '../bloc/forgot_password_bloc/forgot_password_bloc.dart';
import '../widgets/password_requirement_viewer.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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
            SizedBox(height: 8),
            Text(AppTexts.enterNewPassword, style: Theme.of(context).fonts.heading2Bold),
            Text(AppTexts.enterNewPasswordDesc, style: Theme.of(context).fonts.textMdRegular),
            SizedBox(height: 24),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              buildWhen: (previous, current) => previous.newPasswordState?.showPassword != current.newPasswordState?.showPassword,
              builder: (context, state) {
                return AppTextField(
                  label: AppTexts.newPassword,
                  obscureText: state.newPasswordState?.showPassword ?? false,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () => context.read<ForgotPasswordBloc>().add(TogglePasswordVisibility()),
                    icon: Icon(
                      state.newPasswordState?.showPassword ?? false ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).colors.graySecondary,
                    ),
                  ),
                  onChanged: (p0) => context.read<ForgotPasswordBloc>().add(EnterPasswordString(p0)),
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
              builder: (context, state) {
                return Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    Text(AppTexts.passwordRequirements, style: Theme.of(context).fonts.textSmBold.copyWith(color: Theme.of(context).colors.textSecondary)),
                    PasswordRequirementViewer(isPassed: state.newPasswordState?.has8Characters ?? false, text: AppTexts.eightCharacters),
                    PasswordRequirementViewer(isPassed: state.newPasswordState?.hasNumber ?? false, text: AppTexts.aNumber),
                    PasswordRequirementViewer(isPassed: state.newPasswordState?.hasUppercaseCharacter ?? false, text: AppTexts.anUpperCase),
                    PasswordRequirementViewer(isPassed: state.newPasswordState?.hasLowercaseCharacter ?? false, text: AppTexts.anLowerCase),
                    PasswordRequirementViewer(isPassed: state.newPasswordState?.hasSpecialCharacter ?? false, text: AppTexts.specialCharacter),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                buildWhen: (previous, current) => previous.newPasswordState?.showConfirmPassword != current.newPasswordState?.showConfirmPassword,
                builder: (BuildContext context, ForgotPasswordState state) {
                  return AppTextField(
                    label: AppTexts.confirmPassword,
                    obscureText: state.newPasswordState?.showConfirmPassword ?? false,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () => context.read<ForgotPasswordBloc>().add(ToggleConfirmPasswordVisibility()),
                      icon: Icon(
                        state.newPasswordState?.showConfirmPassword ?? false ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).colors.graySecondary,
                      ),
                    ),
                    onChanged: (p0) => context.read<ForgotPasswordBloc>().add(EnterConfirmPasswordString(p0)),
                  );
                }),
            if (MediaQuery.viewInsetsOf(context).bottom < 10) ...[
              Expanded(child: SizedBox()),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                buildWhen: (previous, current) => previous.newPasswordState?.isVerificationPassed != current.newPasswordState?.isVerificationPassed,
                builder: (context, state) {
                  return AppButton(
                    text: AppTexts.resetPassword,
                    textColor: Theme.of(context).colors.contrastWhite,
                    color: Theme.of(context).colors.contrastBlack,
                    isActive: state.newPasswordState?.isVerificationPassed ?? false,
                    onTap: () {},
                  );
                },
              )
            ],
            SizedBox(height: 8 + MediaQuery.systemGestureInsetsOf(context).bottom)
          ],
        ),
      ),
    );
  }
}
