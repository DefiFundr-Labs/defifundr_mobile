import 'dart:io';
import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComplianceScreen extends StatefulWidget {
  const ComplianceScreen({Key? key}) : super(key: key);

  @override
  State<ComplianceScreen> createState() => _ComplianceScreenState();
}

class _ComplianceScreenState extends State<ComplianceScreen> {
  int selectedOption = 1; // 0 for Generate, 1 for Write Your Own
  final TextEditingController _complianceController = TextEditingController();

  @override
  void dispose() {
    _complianceController.dispose();
    super.dispose();
  }

  ValueNotifier<ComplianceTypeEnum> complianceType =
      ValueNotifier(ComplianceTypeEnum.aiGeneratedContract);

  ValueNotifier<File?> signatureFile = ValueNotifier(null);
  ValueNotifier<File?> complianceFile = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            width: 24,
            height: 24,
            padding: EdgeInsets.all(8),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff081A5F), width: 4)),
            child: Text(
              "100%",
              style: DefiFundrFonts.b3(context).copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compliance',
                style: DefiFundrFonts.h1(context).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 26.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Create a Fixed Rate contract for individual contractors for your company',
                style: DefiFundrFonts.b3(context).copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Color(0xff505780)),
              ),
              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agreement',
                      style: DefiFundrFonts.h3(context).copyWith(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'use our locally compliant contract, custom templates or upload your own contract that has already been signed.',
                      style: DefiFundrFonts.b3(context).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Color(0xff505780)),
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: complianceType,
                      builder: (context, selectedOption, _) =>
                          SelectComplianceTypeListTile(
                        list: ComplianceTypeEnum.values,
                        titleBuilder: (v) => v.title!,
                        onSelected: (v) => complianceType.value = v,
                        value: selectedOption,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                'Write Your Compliance',
                style: DefiFundrFonts.h3(context)
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),

              // Text area
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: _complianceController,
                  maxLines: null, // Allows for unlimited lines
                  expands: true, // Takes up all available space
                  decoration: const InputDecoration(
                    hintText: 'Write your own compliance',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFB5BDC9),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1A1A2C),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                'Upload Compliance',
                style: DefiFundrFonts.h3(context)
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),

              // Upload compliance file
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/upload-compliance.svg',
                      width: 25,
                      height: 36,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 16),
                    ValueListenableBuilder(
                      valueListenable: complianceFile,
                      builder: (context, file, _) => Expanded(
                        child: Text(
                          file != null
                              ? file.getPreview(length: 5)
                              : 'Upload Compliance',
                          style: DefiFundrFonts.h3(context).copyWith(
                              fontWeight: FontWeight.w500, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        complianceFile.value = await pickFile();
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                'Upload Signature',
                style: DefiFundrFonts.h3(context)
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/icons/upload-signature.svg',
                        width: 35,
                        height: 35,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ValueListenableBuilder(
                        valueListenable: signatureFile,
                        builder: (context, file, _) {
                          return Expanded(
                            child: Text(
                              file != null
                                  ? file.getPreview(length: 5)
                                  : 'Upload Signature',
                              style: DefiFundrFonts.h3(context).copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16.sp),
                            ),
                          );
                        }),
                    TextButton(
                      onPressed: () async {
                        signatureFile.value = await pickFile();
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              AppButton(
                text: "Continue",
                textColor: Colors.white,
                onTap: () {},
                color: Colors.black,
                borderRadius: 32,
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectComplianceTypeListTile<T> extends StatelessWidget {
  final Function(T) onSelected;
  final ComplianceTypeEnum? value;
  final List<T> list;
  final String Function(T) titleBuilder;
  const SelectComplianceTypeListTile(
      {super.key,
      this.value,
      required this.onSelected,
      required this.list,
      required this.titleBuilder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: list.map((item) {
        return GestureDetector(
          onTap: () => onSelected(item),
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 9.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Color(0xFFEBE8FD))),
            child: Row(
              children: [
                SvgPicture.asset(
                  value == item
                      ? 'assets/icons/checked.svg'
                      : 'assets/icons/unchecked.svg',
                  height: 16.h,
                  width: 16.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  titleBuilder(item),
                  style: DefiFundrFonts.b2(context).copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: item != value ? Color(0xFFBABABA) : null),
                ),
              ],
            ), // Example representation
          ),
        );
      }).toList(),
    );
  }
}

enum ComplianceTypeEnum {
  aiGeneratedContract(title: "Generate Contract Template With  AI", value: 0),
  customCompliance(title: "Write your own compliance", value: 1);

  final String? title;
  final num? value;
  const ComplianceTypeEnum({this.title, this.value});
}
