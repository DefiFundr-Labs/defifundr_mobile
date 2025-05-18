import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart' show AppColors;
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/shared/appbar/appbar.dart';
import '../../../core/shared/auth_header.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();

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
                    color: AppColors.black100,
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
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            children: [
              AuthHeader(
                title: AppTexts.resetPassword,
                subtitle: AppTexts.enterEmailAddress,
              ),
              VerticalMargin(20),
              AppTextField(
                label: AppTexts.emailAddress,
                controller: _passwordController,
              ),
              Spacer(),
              AppButton(
                text: AppTexts.sendCode,
                color: AppColors.primaryColor,
                textColor: AppColors.white100,
                onTap: () => context.pushNamed(RouteConstants.authRoute.verifyOtp),
              )
            ],
          ),
        ),
      )),
    );
  }
}
