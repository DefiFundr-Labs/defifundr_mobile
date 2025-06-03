// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar_header.dart';
import 'package:defifundr_mobile/core/shared/or_widget.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/primary_button.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              AppBarHeaderWidget(),
              SizedBox(height: 32.h),
              Text(
                'Welcome Back!',
                style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Enter your details below to login to your account.',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textTheme.bodyMedium?.color,
                ),
              ),
              SizedBox(height: 24.h),
              AppTextField(
                label: 'Email address',
                obscureText: false,
                controller: _emailController,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                label: 'Password',
                obscureText: _obscurePassword,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Theme.of(context).colors.graySecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: context.theme.textTheme.headlineLarge?.copyWith(
                      color: AppColors.brandDefaultContrast,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryButton(
                text: "Log In",
                onPressed: () {},
              ),
              SizedBox(height: 24.h),
              ORWidget(),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.grayQuaternary,
                    side: BorderSide(color: AppColors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.googleIcon),
                      const SizedBox(width: 12),
                      Text(
                        'Log in using Google',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.grayQuaternary,
                    side: BorderSide(color: AppColors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.appleIcon),
                      const SizedBox(width: 12),
                      Text(
                        'Log in using Apple',
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(RouteConstants.upcomingPayments);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Sign up',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.buttonTheme.colorScheme!.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: Container(
                  width: 134,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
