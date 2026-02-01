import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar_header.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common_ui/components/or_widget.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/create_account/widget/terms_and_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool showError = false;

  ValueNotifier<TextInputFormatter?> inputFormatter = ValueNotifier(null);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Create An Account',
                  style: context.theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 24.sp,
                    color: context.theme.colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Enter your details below to create your account.',
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  labelText: 'Legal first name',
                  controller: _firstNameController,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  labelText: 'Legal last name',
                  controller: _lastNameController,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  labelText: 'Email address',
                  controller: _emailController,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: "Create account",
                  onPressed: () {
                    context.router.push(const QuickPayHomeRoute());
                  },
                ),
                SizedBox(height: 24.h),
                ORWidget(),
                SizedBox(height: 24.h),
                SecondaryButton(
                  text: 'Sign up using Google',
                  icon: AppAssets.googleIcon,
                  onPressed: () {
                    context.router.push(const QuickPayHomeRoute());
                  },
                ),
                SizedBox(height: 16.h),
                SecondaryButton(
                  text: 'Sign up using Apple',
                  icon: AppAssets.appleIcon,
                  onPressed: () {
                    // Handle Apple login
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: context.theme.fonts.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(const ResetPasswordRoute());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Login',
                        style: context.theme.fonts.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colors.brandDefault,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TermsAgreementText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
