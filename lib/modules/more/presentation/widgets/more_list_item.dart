import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MoreItemTrailingType { chevron, toggle, externalLink }

class MoreListItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final MoreItemTrailingType trailingType;
  final bool? toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onTap;

  const MoreListItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingType = MoreItemTrailingType.chevron,
    this.toggleValue,
    this.onToggleChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return InkWell(
      onTap: trailingType != MoreItemTrailingType.toggle ? onTap : null,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: fonts.textBaseMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            _buildTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    final colors = context.theme.colors;

    switch (trailingType) {
      case MoreItemTrailingType.chevron:
        return Icon(
          Icons.chevron_right,
          color: colors.textTertiary,
          size: 20.w,
        );
      case MoreItemTrailingType.toggle:
        return Switch(
          value: toggleValue ?? false,
          onChanged: onToggleChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: colors.brandDefault,
        );
      case MoreItemTrailingType.externalLink:
        return Icon(
          Icons.north_east,
          color: colors.textTertiary,
          size: 18.w,
        );
    }
  }
}
