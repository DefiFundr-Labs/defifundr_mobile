import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_texts.dart';
import '../../../../../core/design_system/theme_extension/app_theme_extension.dart';
import '../../../../../core/shared/common_ui/buttons/primary_button.dart';
import '../../../../authentication/presentation/forget_password/bloc/forgot_password_bloc.dart';
import '../../../../authentication/presentation/forget_password/widget/password_requirement_viewer.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Create Your Password",
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: context.theme.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Enter password to keep your account safe and secure.",
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      buildWhen: (previous, current) =>
                          previous.newPasswordState?.hidePassword !=
                          current.newPasswordState?.hidePassword,
                      builder: (context, state) {
                        return AppTextField(
                          controller: TextEditingController(),
                          labelText: AppTexts.newPassword,
                          hideText:
                              state.newPasswordState?.hidePassword ?? false,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          suffixType: SuffixType.customIcon,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(TogglePasswordVisibility());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SvgPicture.asset(
                                state.newPasswordState?.hidePassword ?? false
                                    ? Assets.icons.eyeIcon
                                    : Assets.icons.crossEye,
                                height: 15.sp,
                                width: 15.h,
                                colorFilter: ColorFilter.mode(
                                  context.theme.colors.textSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (p0) => context
                              .read<ForgotPasswordBloc>()
                              .add(EnterPasswordString(p0)),
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
                            Text(AppTexts.passwordRequirements,
                                style: Theme.of(context)
                                    .fonts
                                    .textSmBold
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colors
                                            .textSecondary)),
                            PasswordRequirementViewer(
                                isPassed:
                                    state.newPasswordState?.has8Characters ??
                                        false,
                                text: AppTexts.eightCharacters),
                            PasswordRequirementViewer(
                                isPassed:
                                    state.newPasswordState?.hasNumber ?? false,
                                text: AppTexts.aNumber),
                            PasswordRequirementViewer(
                                isPassed: state.newPasswordState
                                        ?.hasUppercaseCharacter ??
                                    false,
                                text: AppTexts.anUpperCase),
                            PasswordRequirementViewer(
                                isPassed: state.newPasswordState
                                        ?.hasLowercaseCharacter ??
                                    false,
                                text: AppTexts.anLowerCase),
                            PasswordRequirementViewer(
                                isPassed: state.newPasswordState
                                        ?.hasSpecialCharacter ??
                                    false,
                                text: AppTexts.specialCharacter),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                        buildWhen: (previous, current) =>
                            previous.newPasswordState?.hideConfirmPassword !=
                            current.newPasswordState?.hideConfirmPassword,
                        builder:
                            (BuildContext context, ForgotPasswordState state) {
                          return AppTextField(
                            controller: TextEditingController(),
                            labelText: AppTexts.confirmPassword,
                            hideText:
                                state.newPasswordState?.hideConfirmPassword ??
                                    false,
                            keyboardType: TextInputType.visiblePassword,
                            suffixType: SuffixType.customIcon,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<ForgotPasswordBloc>()
                                    .add(ToggleConfirmPasswordVisibility());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SvgPicture.asset(
                                  state.newPasswordState?.hideConfirmPassword ??
                                          false
                                      ? Assets.icons.eyeIcon
                                      : Assets.icons.crossEye,
                                  height: 15.sp,
                                  width: 15.h,
                                  colorFilter: ColorFilter.mode(
                                    context.theme.colors.textSecondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (p0) => context
                                .read<ForgotPasswordBloc>()
                                .add(EnterConfirmPasswordString(p0)),
                          );
                        }),
                    // Add extra space to ensure content is not hidden behind button
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            // Fixed button at bottom
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  buildWhen: (previous, current) =>
                      previous.newPasswordState?.isVerificationPassed !=
                      current.newPasswordState?.isVerificationPassed,
                  builder: (context, state) {
                    return PrimaryButton(
                      text: AppTexts.resetPassword,
                      isEnabled:
                          state.newPasswordState?.isVerificationPassed ?? false,
                      onPressed: () {
                        context.pushNamed(RouteConstants.passwordReset);
                      },
                    );
                  },
                ),
                SizedBox(height: 20.sp),
                if (MediaQuery.viewInsetsOf(context).bottom < 10)
                  SizedBox(
                      height:
                          8 + MediaQuery.systemGestureInsetsOf(context).bottom),
              ],
            ),
          ],
        ));
  }
}
