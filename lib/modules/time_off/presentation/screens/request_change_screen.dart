import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RequestChangeScreen extends StatelessWidget {
  const RequestChangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeFiRaiseAppBar(
        title: 'Request Change',
        isBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request a change to your time off request',
              style: context.theme.fonts.heading3SemiBold,
            ),
            SizedBox(height: 16.h),
            Text(
              'Describe the changes you would like to make to your time off request.',
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Enter your change request...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            PrimaryButton(
              text: 'Submit Request',
              onPressed: () {
                // Handle submit
                context.router.maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
