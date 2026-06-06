import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewSignBottomSheet extends StatefulWidget {
  final VoidCallback onSign;
  const ReviewSignBottomSheet({super.key, required this.onSign});

  @override
  State<ReviewSignBottomSheet> createState() => _ReviewSignBottomSheetState();
}

class _ReviewSignBottomSheetState extends State<ReviewSignBottomSheet> {
  bool _agreed = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 12, 20, MediaQuery.of(context).viewInsets.bottom + 32.h),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: context.theme.colors.strokeSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text('Review & Sign', style: context.theme.fonts.heading2Bold),
          SizedBox(height: 4.h),
          Text(
            'Ensure you have read and understood the terms in the contract. Type your name below to sign.',
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 61.h,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                _nameController.text.isEmpty
                    ? 'Signature preview'
                    : _nameController.text,
                style: GoogleFonts.dancingScript(
                  fontSize: 24.sp,
                  color: context.theme.colors.textPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: _nameController,
            hintText: 'Legal full name',
            onChanged: (val) => setState(() {}),
          ),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _agreed,
                onChanged: (val) => setState(() => _agreed = val ?? false),
                activeColor: context.theme.colors.brandDefault,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                      'I have read, understood, and agree to the terms and conditions set forth in this contract and agree to be legally bound by these terms and conditions by checking this box.',
                      style: context.theme.fonts.textMdRegular),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    textColor: context.theme.colors.textPrimary,
                    color: context.theme.colors.fillTertiary,
                    text: 'Back',
                    onPressed: () => Navigator.of(context).pop()),
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: PrimaryButton(
                  text: 'Sign contract',
                  onPressed: _agreed && _nameController.text.isNotEmpty
                      ? widget.onSign
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
