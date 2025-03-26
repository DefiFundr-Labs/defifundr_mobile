import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/info_field.dart';
import 'package:flutter/material.dart';

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
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.paymentrate,
              value: '₮ 700.00',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            InfoField(
              label: AppTexts.paymentFrequency,
              value: 'Monthly',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.startDate,
              value: 'Monthly',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.endDate,
              value: '24th Febuary, 2025',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.invoiceCycle,
              value: 'Weekly',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
