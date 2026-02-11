import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AttachmentSection extends StatelessWidget {
  final String? attachmentName;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const AttachmentSection({
    Key? key,
    this.attachmentName,
    required this.onUpload,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachment (Optional)',
          style: context.theme.fonts.textMdMedium.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.theme.colors.textPrimary,
          ),
        ),
        SizedBox(height: 12.0),
        if (attachmentName == null)
          GestureDetector(
            onTap: onUpload,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: context.theme.colors.brandFill,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: context.theme.colors.brandDefaultContrast,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Click to upload',
                    style: context.theme.fonts.textMdMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colors.brandDefaultContrast,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: context.theme.colors.bgB0,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                SvgPicture.asset(Assets.icons.file),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    attachmentName!,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onRemove,
                  child: SvgPicture.asset(
                    Assets.icons.trash,
                  ),
                ),
              ],
            ),
          ),
        if (attachmentName == null) ...[
          SizedBox(height: 8.0),
          SizedBox(
            width: context.screenWidth(),
            child: Text.rich(
              TextSpan(
                style: context.theme.fonts.textBaseMedium.copyWith(
                  color: context.theme.colors.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
                children: [
                  TextSpan(
                    text: 'Supported formats: ',
                  ),
                  TextSpan(
                    text: 'JPG, PNG, HEIC or PDF. ',
                    style: context.theme.fonts.textBaseSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                  TextSpan(
                    text: 'Use ',
                  ),
                  TextSpan(
                    text: '.ZIP',
                    style: context.theme.fonts.textBaseSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                  TextSpan(
                    text: ' to upload multiple files.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
