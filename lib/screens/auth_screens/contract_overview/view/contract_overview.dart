import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/contract_basic_details.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/contract_compliance.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/contract_compliance_document.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/contract_payment_details.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/contract_role_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContractOverview extends StatefulWidget {
  const ContractOverview({super.key});

  @override
  State<ContractOverview> createState() => _ContractOverviewState();
}

class _ContractOverviewState extends State<ContractOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(AppAssets.closeIcon2,
                        width: 14, height: 14)),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppTexts.contractOverview,
                  style: Config.h2(context).copyWith(fontSize: 26),
                ),
              ),
              SizedBox(height: 24),
              ContractBasicDetails(),
              SizedBox(height: 20),
              ContractRoleDetails(),
              SizedBox(height: 20),
              ContractPaymentDetails(),
              SizedBox(height: 20),
              ContractComplaince(),
              SizedBox(height: 20),
              ContractComplainceDocument(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AppButton(
                    height: 56,
                    text: 'Edit Contract',
                    color: AppColors.lightgrey626,
                    textColor: AppColors.white100,
                    onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AppButton(
                    height: 56,
                    text: 'Continue',
                    color: AppColors.primaryColor,
                    textColor: AppColors.white100,
                    onTap: () {}),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
