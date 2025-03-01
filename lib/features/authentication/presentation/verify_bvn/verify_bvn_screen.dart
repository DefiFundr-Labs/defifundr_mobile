import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyBVNScreen extends StatefulWidget {
  const VerifyBVNScreen({super.key});

  @override
  State<VerifyBVNScreen> createState() => _VerifyBVNScreenState();
}

class _VerifyBVNScreenState extends State<VerifyBVNScreen> {
  final TextEditingController _bvnController = TextEditingController();
  final FocusNode _bvnFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _bvnFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _bvnController.dispose();
    _bvnFocusNode.dispose();
    super.dispose();
  }

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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/headset.svg', width: 16.w, height: 16.w),
                      SizedBox(width: 4.w),
                      Text(
                        AppTexts.needHelp,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.black100,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.white100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text(
                AppTexts.verifyWithBVN,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black100,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppTexts.verifyWithBVNDesc,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.black100.withOpacity(0.6),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 72.h,
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  controller: _bvnController,
                  focusNode: _bvnFocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.black100,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    hintText: AppTexts.enterBVN,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textHintColor,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SvgPicture.asset('assets/icons/person.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.white100,
                    contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    AppTexts.bvnDigits,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey500,
                    ),
                  ),
                ),
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
                      AppTexts.bvnSafeAndSecure,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleText,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppTexts.bvnIdentityDesc,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.purpleText,
                        fontWeight: FontWeight.w200,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppTexts.bvnSecurityDesc,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.purpleText,
                        fontWeight: FontWeight.w200,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppTexts.getBVNInstruction,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleTextLight,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 280.w,
                  height: 52.h,
                  child: TextButton(
                    onPressed: () {
                      // Handle BVN verification
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.black100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      AppTexts.continuee,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white100,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Container(
                  width: 134.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
} 