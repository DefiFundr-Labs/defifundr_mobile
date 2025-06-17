import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar_header.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common_ui/components/or_widget.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
                  'Welcome Back!',
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 24.sp,
                    color: context.theme.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Enter your details below to login to your account.',
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  labelText: 'Email address',
                  controller: _emailController,
                ),
                SizedBox(height: 12.h),
                ValueListenableBuilder<TextInputFormatter?>(
                    valueListenable: inputFormatter,
                    builder: (context, inputFormatter, _) {
                      return AppTextField(
                        controller: _passwordController,
                        labelText: 'Enter password',
                        errorTextOnValidation: 'Password is required',
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
                      context.pushNamed(RouteConstants.forgotPassword);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot password?',
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
                  text: "Log In",
                  onPressed: () {
                    context.pushNamed(RouteConstants.quickPayScreen);
                  },
                ),
                SizedBox(height: 24.h),
                ORWidget(),
                SizedBox(height: 24.h),
                SecondaryButton(
                  text: 'Log in using Google',
                  icon: AppAssets.googleIcon,
                  onPressed: () {
                    context.pushNamed(RouteConstants.quickPayScreen);
                  },
                ),
                SizedBox(height: 16.h),
                SecondaryButton(
                  text: 'Log in using Apple',
                  icon: AppAssets.appleIcon,
                  onPressed: () {
                    // Handle Apple login
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: context.theme.fonts.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(RouteConstants.profileCreated);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign up',
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
