import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/shared/auth_header.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppIcons.backIcon),
          onPressed: () {
            context.pop();
          },
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
                  color: AppColors.borderColor,
                  width: 1, // Border width
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.headsetIcon,
                    fit: BoxFit.scaleDown,
                  ),
                  HorizontalMargin(6),
                  Text(
                    AppTexts.needHelp,
                    style: Config.h2(context).copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              AppIcons.gradientBackground,
            ),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Align(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(
                      title: AppTexts.forgetPassword,
                      subtitle: AppTexts.oppsDontWorry,
                    ),
                    Text(
                      AppTexts.theProcessIsSimpler,
                      style: Config.b3(context).copyWith(
                        color: AppColors.grey100,
                      ),
                    ),
                    VerticalMargin(20),
                    AppTextField(
                      isPassword: false,
                      label: 'test@defifundr.com',
                      controller: _emailController,
                      prefixIcon: SvgPicture.asset(
                        AppIcons.userIcon,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    VerticalMargin(30),
                    AppButton(
                        text: AppTexts.continuee,
                        color: AppColors.primaryColor,
                        textColor: AppColors.white100,
                        onTap: () {})
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
