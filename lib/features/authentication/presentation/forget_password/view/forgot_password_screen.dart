import 'package:defifundr_mobile/core/global/constants/app_icons.dart';
import 'package:defifundr_mobile/core/global/constants/app_texts.dart';
import 'package:defifundr_mobile/core/global/constants/size.dart';
import 'package:defifundr_mobile/core/global/themes/color_scheme.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/button/buttons.dart';
import 'package:defifundr_mobile/core/shared/textfield/textfield.dart';
import 'package:defifundr_mobile/core/utils/input_validation.dart';
import 'package:defifundr_mobile/core/utils/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  final String? user;
  const ForgotPasswordScreen({this.user, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetEmailScreenState();
}

class _ResetEmailScreenState extends ConsumerState<ForgotPasswordScreen>
    with InputValidationMixin, LoadingOverlayMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final isValidate = ValueNotifier<bool>(false);

  @override
  void initState() {
    _emailNode.requestFocus();
    _emailController.addListener(_checkValidation);
    super.initState();
  }

  void _checkValidation() {
    setState(() {
      isValidate.value = _emailController.text.isNotEmpty;
    });
  }

@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFEDEAFF), // Adjust based on your image
          Color(0xFFF6F9FC), // Adjust based on your image
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent, // Make Scaffold background transparent
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: AppBar(
          backgroundColor: Colors.transparent, // Make AppBar transparent
          elevation: 0, // Remove shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFEDEAFF), // Adjust based on your image
                  Color(0xFFF6F9FC), // Adjust based on your image
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
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
                  borderRadius: BorderRadius.circular(20), // Set border radius
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.headSetIcon,
                      fit: BoxFit.scaleDown,
                    ),
                    HorizontalMargin(6),
                    Text(AppTexts.neeHelp,
                        style: Config.h2(context).copyWith(
                          fontSize: 10,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppTexts.forgotPassword,
                      style: Config.h2(context).copyWith(fontSize: 24)),
                  VerticalMargin(5),
                  Text(AppTexts.forgotPasswordDesc,
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      )),
                  VerticalMargin(50),
                  AppTextField(
                    controller: _emailController,
                    hintText: AppTexts.forgetPasswordLogin,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    focusNode: _emailNode,
                    textInputAction: TextInputAction.next,
                    prefixIcon: SvgPicture.asset(AppIcons.userIcon,
                        fit: BoxFit.scaleDown),
                    validator: isValidate.value
                        ? combine([
                            withMessage(AppTexts.fieldEmpty("Email"), isTextEmpty),
                          ])
                        : null,
                  ),
                  VerticalMargin(20),
                  VerticalMargin(10),
                  AppButton(
                    isActive: isValidate.value,
                    text: AppTexts.forgotPasswordButton,
                    onTap: () {},
                    textSize: 12,
                    textColor: AppColors.white100,
                    color: AppColors.primaryColor,
                  )
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