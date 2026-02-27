import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar_header.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/components/or_widget.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool showError = false;

  // final PhoneInput phoneInput = PhoneInput.nigeria();
  ValueNotifier<TextInputFormatter?> inputFormatter = ValueNotifier(null);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                AppBarHeaderWidget(),
                SizedBox(height: 32.h),
                Text(
                  context.l10n.welcomeBack,
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 24.sp,
                    color: context.theme.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.l10n.enterYourDetailsBelowToLoginToYourAccount,
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  labelText: context.l10n.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(height: 12.h),
                ValueListenableBuilder<TextInputFormatter?>(
                    valueListenable: inputFormatter,
                    builder: (context, inputFormatter, _) {
                      return AppTextField(
                        controller: _passwordController,
                        labelText: context.l10n.enterPassword,
                        errorTextOnValidation:
                            context.l10n.passwordRequirementsTitle,
                        hideText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          inputFormatter ??
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        textInputAction: TextInputAction.done,
                        suffixType: SuffixType.customIcon,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SvgPicture.asset(
                              _obscurePassword
                                  ? AppIcons.eyeIcon
                                  : AppIcons.crossEyeIcon,
                              height: 15.sp,
                              width: 15.h,
                              colorFilter: ColorFilter.mode(
                                context.theme.colors.textSecondary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.router.push(const ResetPasswordRoute());
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      context.l10n.forgotPassword,
                      style: context.theme.fonts.textBaseMedium.copyWith(
                        color: context.theme.colors.brandDefault,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                PrimaryButton(
                  text: context.l10n.logIn,
                  onPressed: () {
                    final userName =
                        _emailController.text.trim().split('@').first;
                    context.router.push(
                      PinCodeRoute(
                        userName: userName,
                        biometricType: BiometricType.fingerprint,
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                ORWidget(),
                SizedBox(height: 24.h),
                SecondaryButton(
                  text: context.l10n.logInUsingGoogle,
                  icon: AppAssets.googleIcon,
                  onPressed: () {
                    // context.router.push(
                    //   PinCodeRoute(
                    //     userName: 'Google User',
                    //     biometricType: BiometricType.fingerprint,
                    //   ),
                    // );
                    context.router.push(const SampleBottomSheetRoute());
                  },
                ),
                SizedBox(height: 16.h),
                SecondaryButton(
                  text: context.l10n.logInUsingApple,
                  icon: AppAssets.appleIcon,
                  onPressed: () {
                    // context.router.push(
                    //   PinCodeRoute(
                    //     userName: 'Apple User',
                    //     biometricType: BiometricType.faceId,
                    //   ),
                    // );
                    context.router.push(const SampleBottomSheetRoute());
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.forgotYourPin,
                      style: context.theme.fonts.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(const CreateAccountRoute());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        context.l10n.signUp,
                        style: context.theme.fonts.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colors.brandDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
