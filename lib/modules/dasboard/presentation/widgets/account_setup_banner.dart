import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSetupBanner extends StatelessWidget {
  final double progress;

  const AccountSetupBanner({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: () {
        context.router.push(const OnboardingChecklistRoute());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.brandDefault,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete Account Setup',
                    style: fonts.textBaseSemiBold.copyWith(
                      color: isLightMode
                          ? colors.contrastWhite
                          : colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Finish setting up your account to start sending invoices and signing contracts.',
                    style: fonts.textSmRegular.copyWith(
                      color: isLightMode
                          ? colors.contrastWhite
                          : colors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _buildCircularProgress(context, isLightMode, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress(
      BuildContext context, bool isLightMode, AppColorExtension colors) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 4,
              backgroundColor: Colors.white.withAlpha(60),
              valueColor: AlwaysStoppedAnimation<Color>(
                isLightMode ? Colors.white : colors.textPrimary,
              ),
            ),
          ),
          Text(
            '${(progress * 100).round()}%',
            style: context.theme.fonts.textMdMedium.copyWith(
              color: isLightMode ? Colors.white : colors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
