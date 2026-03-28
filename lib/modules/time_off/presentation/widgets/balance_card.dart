import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final int days;
  final VoidCallback? onViewDetails;
  final VoidCallback? onTap;

  const BalanceCard({
    Key? key,
    required this.title,
    required this.days,
    this.onViewDetails,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.theme.colors.bgB1,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: context.theme.colors.constantDefault,
                spreadRadius: -5,
                blurRadius: 1,
                offset: Offset(0, -1),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: context.theme.fonts.textMdRegular
                    .copyWith(color: context.theme.colors.textSecondary)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('$days days', style: context.theme.fonts.heading3SemiBold),
                const Spacer(),
                if (onViewDetails != null)
                  GestureDetector(
                    onTap: onViewDetails,
                    child: Text('View details',
                        style: context.theme.fonts.textSmSemiBold.copyWith(
                            color: context.theme.colors.brandDefaultContrast)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
