import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IncompleteRegistartionScreen extends StatelessWidget {
  const IncompleteRegistartionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.backgroundnewImagePath,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size(context.screenWidth(), 60),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(AppAssets.closeIcon),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppTexts.incompleteRegistration,
                    style: Config.h2(context).copyWith(fontSize: 26),
                  ),
                ),
                SizedBox(height: 3),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 84),
                    child: Text(
                      textAlign: TextAlign.center,
                      AppTexts.weNotifiedthatyourprofilewasnot,
                      style: Config.h2(context).copyWith(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(height: 64),
                SvgPicture.asset(AppAssets.incompleteRegistrationImagePath),
                SizedBox(height: 29),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AppButton(
                    text: AppTexts.proceed,
                    textColor: AppColors.bgB0,
                    color: AppColors.activeButtonDark,
                    onTap: () {},
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppTexts.nothankyou,
                   
                    style: Config.h2(context).copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
