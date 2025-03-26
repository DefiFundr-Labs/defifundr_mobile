import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/widgets/info_field.dart';
import 'package:flutter/material.dart';

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
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            InfoField(
              label: AppTexts.seniorityLevel,
              value: 'Expert',
              labelStyle: Config.h2(context)
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
              valueStyle: Config.h2(context).copyWith(
                  fontSize: 12,
                  color: AppColors.purple505,
                  fontWeight: FontWeight.w500),
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
                            style: Config.h2(context).copyWith(fontSize: 12, color: AppColors.purple505),
                          ),
                        ],
                      ),
                      Text(
                        "Work Duty and Professional Compliance Team Member Duties and ResponsibilitiesProfessional Conduct Standards: [Standards team members must adhere to",
                        style: Config.h2(context).copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.purple505),
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
