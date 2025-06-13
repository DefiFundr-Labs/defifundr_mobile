import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FundWalletDetails extends StatefulWidget {
  const FundWalletDetails({super.key});

  @override
  State<FundWalletDetails> createState() => _FundWalletDetailsState();
}

class _FundWalletDetailsState extends State<FundWalletDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgB1,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Icon(Icons.question_mark),
                      Text(
                        AppTexts.needHelp,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Color(0xff18181B),
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 16 / 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                  color: AppColors.bgB0,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: Image.asset(AppAssets.warning),
                ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    width: 283.w,
                    child: Text.rich(
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          color: AppColors.textPrimary),
                      TextSpan(children: [
                        TextSpan(text: "Send only "),
                        TextSpan(
                            text: "ETH ",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                color: AppColors.brandContrast)),
                        TextSpan(text: "via the "),
                        TextSpan(
                            text: "Ethereum ",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                color: AppColors.brandContrast)),
                        TextSpan(
                            text:
                                "network. Using any other asset or network will result in permanent loss."
                                )
                      ]),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                decoration: BoxDecoration(
                    color: AppColors.bgB0,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  children: [

                    //QR CODE
                    SizedBox(
                      width: 183.w,
                      height: 183.w,
                      child: SvgPicture.asset(
                        AppIcons.qrcode,
                        width: 36.w,
                        height: 36.w,
                      ),
                    ),

                    
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Network",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            )),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.eth,
                              width: 20.w,
                              height: 20.w,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 4.h),
                            Text("Ethereum",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Asset",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            )),
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.ethDark,
                              width: 20.w,
                              height: 20.w,
                            ),
                            SizedBox(width: 2),
                            Text("ETH",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Address",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ))),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 257.w,
                            child: Text(
                                "0xfEBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ))),
                        InkWell(child: Icon(Icons.copy_outlined)),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 50.h),
            MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              onPressed: () {},
              color: AppColors.brandDefault,
              shape: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_sharp, color: AppColors.bgB0),
                  Text(
                    "Share Address",
                    style: TextStyle(
                      color: AppColors.bgB0,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
