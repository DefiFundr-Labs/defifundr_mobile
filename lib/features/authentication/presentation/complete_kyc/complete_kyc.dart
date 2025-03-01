import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteKyc extends StatelessWidget {
  const CompleteKyc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56),
            Text(
              'Complete KYC.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                letterSpacing: 0.0,
                height: 21 / 15,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
              ),
            ),
            Text(
              'Tell us about the type of personal account you are trying to open ',
              style: TextStyle(
                color: Color(0xff626F84),
                fontSize: 12,
                letterSpacing: 0.0,
                height: 21 / 15,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.hankenGrotesk().fontFamily,
              ),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 26),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.sss),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verify Identity",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                          Text(
                            "Allow us to verify your documents ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 26),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.sss),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create a Contract",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                          Text(
                            "Allow us to verify your documents",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 26),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.sss),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Complice",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                          Text(
                            "Allow us to verify your documents",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black100,
                            ),
                          ),
                        ],
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
