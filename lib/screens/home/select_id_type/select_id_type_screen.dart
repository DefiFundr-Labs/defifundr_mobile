import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/screens/home/select_id_type/widget/id_type_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_texts.dart';


class SelectIdTypeScreen extends StatefulWidget {
  const SelectIdTypeScreen({Key? key}) : super(key: key);

  @override
  State<SelectIdTypeScreen> createState() => _SelectIdTypeScreenState();
}

class _SelectIdTypeScreenState extends State<SelectIdTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(AppAssets.backArrow, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              )
          ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  AppTexts.selectYourIdType,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black100,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppTexts.wellUseThisInfoToVerify,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.black100.withOpacity(0.6),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 20.h),
                IdTypeWidget(
                    title: AppTexts.ninSlip,
                    onTap: (){}
                ),
                SizedBox(height: 10.h),
                IdTypeWidget(
                    title: AppTexts.votersCard,
                    onTap: (){}
                ),
                SizedBox(height: 10.h),
                IdTypeWidget(
                    title: AppTexts.bvn,
                    onTap: (){}
                ),
                SizedBox(height: 10.h),
                IdTypeWidget(
                    title: AppTexts.driversLicense,
                    onTap: (){}
                ),
                SizedBox(height: 10.h),
                IdTypeWidget(
                    title: AppTexts.internationalPassport,
                    onTap: (){}
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.purpleLight,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.purpleColor.withOpacity(0.5), width: 0.5.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.yourInfoIsSafe,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.purpleText,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppTexts.weOnlyCollectTheNecessaryDetails,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.purpleText,
                          fontWeight: FontWeight.w200,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
