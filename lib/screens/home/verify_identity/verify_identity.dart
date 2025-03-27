import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyIdentity extends StatelessWidget {
  const VerifyIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
      ),
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){},
              child: Image(
                  color: Color(0xff000000),
                  height: 24.h,
                  width: 24.w,
                  image: AssetImage('assets/images/bac.png')),
            ),
            SizedBox(height: 56.h),
            Text(
              'Verify your Identity',
              style: TextStyle(
                  fontFamily: 'HK',
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                  height: 1,


                  color: Color(0xff16192C), letterSpacing: 0),
            ),
            Text(
              'Tell us about the type of personal account you are trying to open ',
              style: TextStyle(
                  fontFamily: 'HK Grotesk',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  height: 18/12,


                  color: Color(0xff505780), letterSpacing: 0),
            ),
            SizedBox(height: 42.h),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: 0.88.sw,
                height: 72.h,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10.0.r)),
                child: Row(
                  children: [
                    Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 22.h),
                        child: Image.asset('assets/images/face.png'),
                      ),

                    ),
                    SizedBox(width: 0.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Face Verification",
                            style: TextStyle(
                                fontFamily: 'HK Grotesk',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                height: 20/16,


                                color: Color(0xff000000), letterSpacing: -1),
                          ),
                        ),
                        Text(
                          "Allow us to verify your documents ",
                          style: TextStyle(
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              height: 18/12,


                              color: Color(0xff505780), letterSpacing: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.h),
            GestureDetector(
              onTap: (){},
              child: Container(
                width: 0.88.sw,
                height: 72.h,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 22.h),
                        child: Image.asset('assets/images/id.png'),
                      ),

                    ),
                    SizedBox(width: 0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Identity verification",
                            style: TextStyle(
                                fontFamily: 'HK Grotesk',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                height: 20/16,


                                color: Color(0xff000000), letterSpacing: -1),
                          ),
                        ),
                        Text(
                          "Allow us to verify your documents ",
                          style: TextStyle(
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              height: 18/12,


                              color: Color(0xff505780), letterSpacing: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
