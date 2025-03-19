import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/type_of_account/select_account_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TypeOfAccount extends StatefulWidget {
  const TypeOfAccount({super.key});

  @override
  State<TypeOfAccount> createState() => _TypeOfAccountState();
}

class _TypeOfAccountState extends State<TypeOfAccount> {
  final ValueNotifier<String> selectedAccountType = ValueNotifier<String>("");

  @override
  void dispose() {
    selectedAccountType.dispose();
    super.dispose();
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
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.headsetIcon,
                      fit: BoxFit.scaleDown,
                    ),
                    HorizontalMargin(6),
                    Text(
                      AppTexts.needHelp,
                      style: DefiFundrFonts.h2(context).copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            SizedBox(height: 51),
            Text(
              AppTexts.whattypeofaccountareyoucreating,
              style: DefiFundrFonts.h2(context).copyWith(fontSize: 26),
            ),
            Text(
              AppTexts.tellusmoreabouttheaccounttypetypeyouare,
              style: DefiFundrFonts.h2(context).copyWith(fontSize: 12),
            ),
            SizedBox(height: 23),
            SelectAccountType(
              title: AppTexts.businessaccount,
              description: AppTexts.empoweryourbusinessbyusingDefiFundrtopower,
              value: "business",
              groupValueNotifier: selectedAccountType,
              onSelectionChanged: (value) {},
            ),
            SizedBox(height: 16),
            SelectAccountType(
              title: AppTexts.personalaccount,
              description: AppTexts.createapersonalizedaccounttoempower,
              value: "personal",
              groupValueNotifier: selectedAccountType,
              onSelectionChanged: (value) {},
            ),
            Spacer(),
            AppButton(
              text: 'Continue',
              color: AppColors.primaryColor,
              textColor: AppColors.white100,
              onTap: () {},
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
