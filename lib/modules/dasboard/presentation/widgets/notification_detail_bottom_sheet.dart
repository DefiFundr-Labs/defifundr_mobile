import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/dasboard/data/models/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationDetailBottomSheet extends StatelessWidget {
  final NotificationItem notification;

  const NotificationDetailBottomSheet({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 24.h),
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: colors.strokePrimary,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Title',
                    style: fonts.heading2Bold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    '20 April 2025, 04:40 PM',
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textTertiary,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Description',
                    style: fonts.textBaseMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Divider(
                    color: colors.strokeSecondary,
                    height: 1,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Commodo quam pulvinar ut adipiscing. Quis volutpat pretium pellentesque orci urna. Elementum urna augue tortor massa vel amet venenatis etiam tellus. Mattis sed diam consequat maecenas aliquam volutpat gravida magna. Phasellus molestie enim tristique bibendum non. Cursus egestas molestie in urna mauris convallis.',
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                      fontSize: 14.sp,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: 24.h,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Button action',
                    style: fonts.textBaseMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
