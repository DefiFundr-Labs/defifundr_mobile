import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String initials;

  const MoreProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    final fonts = context.theme.fonts;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.moreBg.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    width: 52.w,
                    height: 52.w,
                    decoration: BoxDecoration(
                      color: context.theme.colors.brandFill,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.theme.colors.brandDefault,
                        width: 2.w,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: fonts.textLgBold.copyWith(
                          color: context.theme.colors.brandDefault,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: fonts.textBaseSemiBold.copyWith(
                            color: context.theme.colors.contrastWhite,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          email,
                          style: fonts.textSmRegular.copyWith(
                            color: context.theme.colors.contrastWhite,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
