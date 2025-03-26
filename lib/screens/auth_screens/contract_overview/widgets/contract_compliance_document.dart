import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              style: DefiFundrFonts.h2(context)
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.documentsIcon),
                    SizedBox(width: 6),
                    Text(
                      AppTexts.machinelearningcomplincePDF,
                      style: DefiFundrFonts.h2(context)
                          .copyWith(fontSize: 10, color: AppColors.purple505),
                    ),
                  ],
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
                      style: DefiFundrFonts.h2(context)
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
