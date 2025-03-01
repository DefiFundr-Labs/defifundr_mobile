import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContractOverview extends StatefulWidget {
  const ContractOverview({super.key});

  @override
  State<ContractOverview> createState() => _ContractOverviewState();
}

class _ContractOverviewState extends State<ContractOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: false,
          title: '',
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  text: 'Edit Contract',
                  color: AppColors.grey100,
                  textColor: AppColors.white100,
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: AppButton(
                  text: 'Continue',
                  color: AppColors.primaryColor,
                  textColor: AppColors.white100,
                  onTap: () {}),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ContractPaymentDetails extends StatefulWidget {
  const ContractPaymentDetails({super.key});

  @override
  State<ContractPaymentDetails> createState() =>
      _ContractPaymentDetailssState();
}

class _ContractPaymentDetailssState extends State<ContractPaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 317,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.paymentDetails,
              style: Config.h2(context).copyWith(fontSize: 14),
            ),
            SizedBox(height: 9),
            InfoField(
              label: AppTexts.selectedCurrencyorCoin,
              value: 'USDT (₮)',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.paymentrate,
              value: '₮ 700.00',
            ),
            InfoField(
              label: AppTexts.paymentFrequency,
              value: 'Monthly',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.startDate,
              value: 'Monthly',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.endDate,
              value: '24th Febuary, 2025',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.invoiceCycle,
              value: 'Weekly',
            )
          ],
        ),
      ),
    );
  }
}

class ContractRoleDetails extends StatelessWidget {
  const ContractRoleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.roleDetails,
              style: Config.h2(context).copyWith(fontSize: 14),
            ),
            SizedBox(height: 9),
            InfoField(
              label: AppTexts.role,
              value: ' Data Scientists',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.seniorityLevel,
              value: 'Expert',
            ),
            SizedBox(height: 10),
            Container(
              height: 142,
              width: 333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white100,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFE6E6E6),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.scopeofwork,
                            style: Config.h2(context).copyWith(fontSize: 14),
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppTexts.view,
                            style: Config.h2(context).copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "Work Duty and Professional Compliance Team Member Duties and ResponsibilitiesProfessional Conduct Standards: [Standards team members must adhere to",
                        style: Config.h2(context).copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractComplainceDocument extends StatelessWidget {
  const ContractComplainceDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.complianceDocument,
              style: Config.h2(context).copyWith(fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppTexts.machinelearningcomplincePDF,
                  style: Config.h2(context).copyWith(fontSize: 10),
                ),
                Container(
                  height: 19,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.black100,
                  ),
                  child: Center(
                    child: Text(
                      AppTexts.view,
                      style: Config.h2(context)
                          .copyWith(fontSize: 9, color: AppColors.white100),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContractComplaince extends StatelessWidget {
  const ContractComplaince({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.compliance,
              style: Config.h2(context).copyWith(fontSize: 14),
            ),
            SizedBox(height: 20),
            Container(
              height: 214,
              width: 301,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE6E6E6),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Work Duty and Professional Compliance Team Member Duties and ResponsibilitiesProfessional Conduct Standards: [Standards team members must adhere to",
                  style: Config.h2(context).copyWith(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractBasicDetails extends StatelessWidget {
  const ContractBasicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: 333,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.basicDetails,
              style: Config.h2(context).copyWith(fontSize: 14),
            ),
            SizedBox(height: 9),
            InfoField(
              label: AppTexts.countryoftaxresidence,
              value: 'Nigeria',
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.contractorName,
              value: 'Chibuza Ebenizer',
            )
          ],
        ),
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final double? width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoField({
    Key? key,
    required this.label,
    required this.value,
    this.width,
    this.height = 38,
    this.borderRadius = 10,
    this.borderColor = const Color(0xFFE6E6E6),
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(fontSize: 12);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Text(
              label,
              style: labelStyle ?? defaultStyle,
            ),
            Text(
              ' $value',
              style: valueStyle ?? defaultStyle,
            ),
          ],
        ),
      ),
    );
  }
}
