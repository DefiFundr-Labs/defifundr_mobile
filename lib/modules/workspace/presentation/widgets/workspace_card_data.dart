import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/workspace/data/models/workspace_card_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkspaceCard extends StatelessWidget {
  final WorkspaceCardModel data;
  final bool isLight;
  final dynamic colors;
  final dynamic fonts;

  const WorkspaceCard({
    super.key,
    required this.data,
    required this.isLight,
    required this.colors,
    required this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: colors.bgB1,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              data.iconPath,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(height: 16.h),
            Text(
              data.title,
              style: context.theme.fonts.textMdSemiBold,
            ),
            SizedBox(height: 4.h),
            Text(
              data.description,
              style: fonts.textSmRegular.copyWith(
                color: colors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
