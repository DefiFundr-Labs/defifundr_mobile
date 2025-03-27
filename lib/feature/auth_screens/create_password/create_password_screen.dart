import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/shared/appbar/appbar.dart';
import '../../../core/shared/auth_header.dart';
import '../../../core/themes/color_scheme.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final isHide = ValueNotifier<bool>(true);
  final capital = ValueNotifier<bool>(false);
  final number = ValueNotifier<bool>(false);
  final isNotEmpty = ValueNotifier<bool>(false);
  final special = ValueNotifier<bool>(false);
  final chacterLength = ValueNotifier<bool>(false);
  final enabled = ValueNotifier<bool>(false);
  final isConfirmHide = ValueNotifier<bool>(true);
  final isSwitched = ValueNotifier<bool>(false);
  OverlayEntry? _overlayEntry;

  final passwordMatch = ValueNotifier<bool>(false);
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(_checkChanged);
    _confirmPasswordController.addListener(_checkChangedConfirm);

    super.initState();
  }

  _checkChangedConfirm() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text &&
              _passwordController.text.isNotEmpty &&
              _confirmPasswordController.text.isNotEmpty;
      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;
    });
  }

  _checkChanged() {
    setState(() {
      passwordMatch.value =
          _passwordController.text == _confirmPasswordController.text;
      capital.value = _passwordController.text.contains(RegExp(r'[A-Z]'));
      number.value = _passwordController.text.contains(RegExp(r'[0-9]'));

      special.value =
          _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      chacterLength.value = _passwordController.text.length >= 8;

      enabled.value = capital.value &&
          number.value &&
          special.value &&
          chacterLength.value &&
          passwordMatch.value;

      isNotEmpty.value = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            isBack: true,
            title: '',
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 25.sp),
                child: Container(
                  width: 107.sp,
                  height: 34.sp,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    border: Border.all(
                      color: AppColors.borderColor, // Border color
                      width: 1, // Border width
                    ),
                    borderRadius:
                        BorderRadius.circular(20), // Set border radius
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.headsetIcon,
                        fit: BoxFit.scaleDown,
                      ),
                      HorizontalMargin(6),
                      Text(AppTexts.needHelp,
                          style: Config.h2(context).copyWith(
                            fontSize: 10,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
          ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            children: [
              AuthHeader(
                title: AppTexts.resetPassword,
                subtitle: AppTexts.addAPasswordToKeepAccountSafe,
              ),
              VerticalMargin(20),
              AppTextField(
                isPassword: isHide.value,
                label: 'Enter password',
                controller: _passwordController,
                prefixIcon: SvgPicture.asset(
                  AppIcons.lockIcon,
                  fit: BoxFit.scaleDown,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHide.value = !isHide.value;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SvgPicture.asset(
                        isHide.value ? AppIcons.eyeIcon : AppIcons.crossEyeIcon,
                        color: AppColors.grey100,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalMargin(20),
              AppTextField(
                isPassword: isConfirmHide.value,
                label: 'Confirm password',
                controller: _confirmPasswordController,
                prefixIcon: SvgPicture.asset(
                  AppIcons.lockIcon,
                  fit: BoxFit.scaleDown,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmHide.value = !isConfirmHide.value;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SvgPicture.asset(
                        isConfirmHide.value
                            ? AppIcons.eyeIcon
                            : AppIcons.crossEyeIcon,
                        color: AppColors.grey100,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalMargin(20),
              _passwordChecker(
                isCapital: capital.value,
                isNumber: number.value,
                isSpecial: special.value,
                isPasswordMatch: passwordMatch.value,
                isCharacterLength: chacterLength.value,
                enabled: enabled.value,
              ),
              Spacer(),
              AppButton(
                  text: 'Continue',
                  color: AppColors.primaryColor,
                  textColor: AppColors.white100,
                  onTap: () {})
            ],
          ),
        ),
      )),
    );
  }

  Container _passwordChecker(
      {required bool isCapital,
      required bool isNumber,
      required bool isSpecial,
      required bool isCharacterLength,
      required bool isPasswordMatch,
      required bool enabled}) {
    return Container(
      child: Column(children: [
        _passwordCheckerItem(
          enabled: isCharacterLength,
          text: AppTexts.minOf8Char,
        ),
        _passwordCheckerItem(
          enabled: isCapital,
          text: AppTexts.atLestOneUpperCase,
        ),
        _passwordCheckerItem(
          enabled: isNumber,
          text: AppTexts.atLestOneNumber,
        ),
        _passwordCheckerItem(
          enabled: isSpecial,
          text: AppTexts.atLestOneSpecialChar,
        ),
        _passwordCheckerItem(
          enabled: isPasswordMatch,
          text: AppTexts.passwordMatch,
        ),
      ]),
    );
  }

  _passwordCheckerItem({required bool enabled, required String text}) {
    return AnimatedContainer(
      curve: Curves.easeInOutBack,
      duration: const Duration(milliseconds: 500),
      child: Row(
        children: [
          Center(
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  color: enabled ? AppColors.purpleColor : AppColors.white100,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(width: 1, color: AppColors.purpleColor)),
            ),
          ),
          HorizontalMargin(5),
          Text(text,
              style: Config.b3(context).copyWith(
                color: AppColors.secondaryTextColor,
              )),
        ],
      ),
    );
  }
}
