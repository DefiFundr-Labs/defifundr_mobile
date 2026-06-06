import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletionBottomSheet extends StatelessWidget {
  final VoidCallback onDone;
  const CompletionBottomSheet({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.theme.colors.brandFill,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.icons.fileTextCopy,
              colorFilter: ColorFilter.mode(
                  context.theme.colors.brandDefault, BlendMode.srcIn),
              height: 40.sp,
              width: 40.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text('Contract created', style: context.theme.fonts.heading2Bold),
          SizedBox(height: 4.h),
          Text(
            'The contract link has been shared with your client, and you can always resend it again from your contract page',
            textAlign: TextAlign.center,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'https://app.defifundr.co/id=96abbf24-34f6-49.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.fonts.textMdMedium,
                  ),
                ),
                SizedBox(width: 12.w),
                PrimaryButton(
                  borderRadius: BorderRadius.circular(8.r),
                  text: 'Copy',
                  fixedSize: Size(68.w, 40.h),
                  color: context.theme.colors.fillTertiary,
                  textColor: context.theme.colors.textPrimary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            text: 'Done',
            onPressed: onDone,
          ),
        ],
      ),
    );
  }
}
