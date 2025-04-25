import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyNINScreen extends StatefulWidget {
  const VerifyNINScreen({super.key});

  @override
  State<VerifyNINScreen> createState() => _VerifyNINScreenState();
}

class _VerifyNINScreenState extends State<VerifyNINScreen> {
  final TextEditingController _ninController = TextEditingController();
  final FocusNode _ninFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _ninFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _ninController.dispose();
    _ninFocusNode.dispose();
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
                  color: AppColors.white100,
                  border: Border.all(color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppAssets.headSetIcon,
                          width: 16.w, height: 16.w),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                // NIN slip image
                Container(
                  width: double.infinity,
                  height: 230.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.ninSlipImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  AppTexts.verifyWithNIN,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black100,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppTexts.verifyWithNINDesc,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.black100.withOpacity(0.6),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: AppColors.bgB1,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: _ninController,
                    focusNode: _ninFocusNode,
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
                      hintText: AppTexts.enterNIN,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.grayTertiary,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppAssets.userIcon,
                          width: 20.w,
                          height: 20.w,
                          color: AppColors.grayTertiary,
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
                      fillColor: AppColors.bgB2,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 16.w),
                    ),
                  ),
                ),

                SizedBox(height: 240.h),
                Center(
                  child: SizedBox(
                    width: 280.w,
                    height: 52.h,
                    child: TextButton(
                      onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
