import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: context.theme.colors.brandFill,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SvgPicture.asset(
                  Assets.icons.clockUser,
                  height: 48.h,
                  width: 48.w,
                  color: Color(0xFF6366F1),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hours worked submitted',
              style: context.theme.fonts.heading2Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              'Submission now awaiting approval. An email has been sent to your client.',
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            PrimaryButton(
              onPressed: () => context.router.maybePop(),
              text: 'Ok',
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
