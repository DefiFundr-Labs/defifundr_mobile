import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceCard extends StatelessWidget {
  const WorkspaceCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final String image;
  final String title;
  final String subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.bgB0,
            boxShadow: [
              BoxShadow(
                  color: AppColors.constantDefault.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: -5,
                  offset: Offset(0, 1)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, height: 32.h, width: 32.h),
              SizedBox(height: 16),
              Text(
                title,
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: context.textTheme.bodySmall
                    ?.copyWith(color: AppColors.textSecondary, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
