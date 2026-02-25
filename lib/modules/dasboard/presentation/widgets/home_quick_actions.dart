import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick actions',
          style: fonts.textMdSemiBold.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: isLightMode ? colors.bgB0 : colors.bgB1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _buildQuickActionItem(
                  context: context,
                  icon: Assets.icons.files,
                  label: 'Contract',
                  onTap: () {},
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: colors.strokeSecondary,
                ),
                _buildQuickActionItem(
                  context: context,
                  icon: Assets.icons.invoice,
                  label: 'Invoice',
                  iconColor: colors.orangeDefault,
                  onTap: () {},
                ),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: colors.strokeSecondary,
                ),
                _buildQuickActionItem(
                  context: context,
                  icon: Assets.icons.handCoins,
                  label: 'Quickpay',
                  iconColor: colors.pinkDefault,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionItem({
    required BuildContext context,
    required String icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 32,
              height: 32,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                  : null,
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: fonts.textSmMedium.copyWith(
                color: colors.textPrimary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
