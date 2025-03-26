import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/themes/color_scheme.dart';

class VerifyPassportScreen extends StatefulWidget {
  const VerifyPassportScreen({super.key});

  @override
  State<VerifyPassportScreen> createState() => _VerifyPassportScreenState();
}

class _VerifyPassportScreenState extends State<VerifyPassportScreen> {
  final TextEditingController _passportController = TextEditingController();
  final FocusNode _passportFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passportFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _passportController.dispose();
    _passportFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: Offset(-8.w, 0),
                      child: IconButton(
                        icon: Icon(CupertinoIcons.back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssets.headSetIcon,
                            width: 16.w,
                            height: 16.h,
                            colorFilter: ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppTexts.needHelp,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                // Passport image
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.passportImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  AppTexts.verifyWithPassport,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppTexts.verifyWithPassportDesc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.black100,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextField(
                    controller: _passportController,
                    focusNode: _passportFocusNode,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 16.w,
                      ),
                      border: InputBorder.none,
                      hintText: AppTexts.enterPassportID,
                      hintStyle: TextStyle(
                        color: AppColors.textHintColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppAssets.userIcon,
                          width: 18.w,
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.subtitleGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 200.h),
                Center(
                  child: SizedBox(
                    width: 280.w,
                    height: 52.h,
                    child: TextButton(
                      onPressed: () {
                        // Handle verification
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.buttonBackground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        AppTexts.continuee,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 