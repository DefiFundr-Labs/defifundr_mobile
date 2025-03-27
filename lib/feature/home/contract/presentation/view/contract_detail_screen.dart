import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/auth_header.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/themes/color_scheme.dart';

class ContractDetailScreen extends StatefulWidget {
  const ContractDetailScreen({super.key});

  @override
  State<ContractDetailScreen> createState() => _ContractDetailScreenState();
}

class _ContractDetailScreenState extends State<ContractDetailScreen> {
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
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset(
                  AppIcons.zeroPercent,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          )),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                AuthHeader(
                  title: AppTexts.createContractDetails,
                  subtitle: AppTexts.kindlyCreateContract,
                ),
                VerticalMargin(10),
                _buildContractCard(
                    AppTexts.fixedRate, AppTexts.empowerYourBusiness),
                VerticalMargin(10),
                _buildContractCard(
                    AppTexts.payAsYouGo, AppTexts.createAPersonalizedAccount),
                VerticalMargin(10),
                _buildContractCard(
                    AppTexts.milestone, AppTexts.createAPersonalizedAccount),
                VerticalMargin(20),
              ]),
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

  Container _buildContractCard(String tile, String subTitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tile,
            style: Config.b2(context).copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.subHeadingBlack),
          ),
          VerticalMargin(5),
          Text(
            subTitle,
            style: Config.b3(context).copyWith(
              color: AppColors.subTitleGray,
            ),
          ),
        ],
      ),
    );
  }
}
