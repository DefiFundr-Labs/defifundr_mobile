import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkScopeRow extends StatelessWidget {
  final String value;
  final bool expanded;
  final VoidCallback onToggle;

  const WorkScopeRow({
    super.key,
    required this.value,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work Scope',
            style: context.theme.fonts.textMdRegular
                .copyWith(color: context.theme.colors.textSecondary),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            maxLines: expanded ? null : 2,
            overflow: expanded ? null : TextOverflow.ellipsis,
            style: context.theme.fonts.textMdMedium,
          ),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              expanded ? 'Show less' : '...Read more',
              style: context.theme.fonts.textMdMedium.copyWith(
                color: context.theme.colors.brandDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
