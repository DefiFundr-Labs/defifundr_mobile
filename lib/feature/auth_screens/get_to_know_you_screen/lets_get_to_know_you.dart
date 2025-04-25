import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/lets_get_to_know_you_bloc.dart';

class LetsGetToKnowYouScreen extends StatefulWidget {
  const LetsGetToKnowYouScreen({Key? key}) : super(key: key);

  @override
  State<LetsGetToKnowYouScreen> createState() => _LetsGetToKnowYouScreenState();
}

class _LetsGetToKnowYouScreenState extends State<LetsGetToKnowYouScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _selectedGender = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _agreeToTerms = false;

  void _updateButtonState() {
    setState(() {}); // Triggers UI rebuild when any field changes
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _firstNameController.addListener(_updateButtonState);
    _lastNameController.addListener(_updateButtonState);
    _selectedGender.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _selectedGender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.activeButton,
      appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            title: '',
            isBack: false,
          )),
      body: BlocListener<LetsGetToKnowYouBloc, LetsGetToKnowYouState>(
        listener: (context, state) {
          if (state is LetsGetToKnowYouError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.errorColor),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppTexts.signUpSuccess), backgroundColor: AppColors.successColor),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppAssets.appIcon, fit: BoxFit.scaleDown),
                    SizedBox(height: 8.h),
                    Text(
                      AppTexts.letsGetToKnowYouTitle,
                      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppTexts.letsGetToKnowYouSub,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.grey300),
                    ),
                    SizedBox(height: 30.h),
                    AppTextField(
                      controller: _emailController,
                      label: AppTexts.email,
                      // inputType: TextInputType.emailAddress,
                      prefixIcon: SvgPicture.asset(AppAssets.userIcon, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 15.h),
                    AppTextField(
                      controller: _firstNameController,
                      label: AppTexts.istName,
                      prefixIcon: SvgPicture.asset(AppAssets.userIcon, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 15.h),
                    AppTextField(
                      controller: _lastNameController,
                      label: AppTexts.lastName,
                      prefixIcon: SvgPicture.asset(AppAssets.userIcon, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 15.h),
                    AppTextField(
                      controller: _selectedGender,
                      label: AppTexts.gender,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: _agreeToTerms,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // Set border radius to 4
                          ),
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 12.sp, color: AppColors.grey200),
                              children: [
                                TextSpan(text: AppTexts.tacText),
                                TextSpan(
                                  text: AppTexts.tosText,
                                  style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()..onTap = () {},
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: AppTexts.ppText,
                                  style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()..onTap = () {},
                                ),
                                TextSpan(text: "."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      text: AppTexts.continueButton,
                      textColor: AppColors.white200,
                      borderRadius: 48.sp,
                      onTap: () {
                        context.read<LetsGetToKnowYouBloc>().add(
                              ValidateSignUp(
                                email: _emailController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                gender: _selectedGender.text,
                                agreeToTerms: _agreeToTerms,
                              ),
                            );
                      }, // Disable the button
                      textSize: 14.sp,
                      color: AppColors.primaryColor, // Grey ut if inactive
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
