import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/info_field.dart';
import 'package:flutter/material.dart';

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
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.contractorName,
              value: 'Chibuza Ebenizer',
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
