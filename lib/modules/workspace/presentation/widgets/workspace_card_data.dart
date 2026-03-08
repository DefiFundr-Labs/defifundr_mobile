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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isLight ? colors.bgB0 : colors.bgB1,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              data.iconPath,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(height: 12.h),
            Text(
              data.title,
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
