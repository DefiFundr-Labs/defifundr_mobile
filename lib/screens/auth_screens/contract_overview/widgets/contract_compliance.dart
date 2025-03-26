import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';

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
                  style: Config.h2(context).copyWith(fontSize: 12, color: AppColors.purple505,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
