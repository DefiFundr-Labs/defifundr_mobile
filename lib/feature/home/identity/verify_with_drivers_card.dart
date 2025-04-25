import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_texts.dart';

class VerifyWithDriversCard extends StatefulWidget {
  const VerifyWithDriversCard({super.key});

  @override
  State<VerifyWithDriversCard> createState() => _VerifyWithDriversCardState();
}

class _VerifyWithDriversCardState extends State<VerifyWithDriversCard> {
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
      ),
      backgroundColor: AppColors.grayTertiary,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalMargin(20),
              Image.asset(
                AppIcons.driversCard,
                fit: BoxFit.cover,
              ),
              VerticalMargin(20),
              FittedBox(
                child: Text(
                  AppTexts.verifyDriversCard,
                  style: Config.h2(context).copyWith(
                    fontSize: 26,
                  ),
                ),
              ),
              Text(
                AppTexts.enterVotersCardNumber,
                style: Config.b3(context).copyWith(
                  color: AppColors.grey100,
                ),
              ),
              VerticalMargin(10),
              AppTextField(
                isPassword: false,
                label: 'Enter driver licence ID',
                controller: TextEditingController(),
                prefixIcon: SvgPicture.asset(
                  AppIcons.userIcon,
                  fit: BoxFit.scaleDown,
                ),
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
}
