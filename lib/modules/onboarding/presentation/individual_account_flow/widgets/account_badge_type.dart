import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AccountTypeCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String? badge;
  final bool isEnabled;
  final VoidCallback onTap;

  const AccountTypeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.badge,
    this.isEnabled = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Card(
      elevation: 0,
      color: !isEnabled ? colors.fillTertiary : colors.bgB0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colors.grayQuaternary.withAlpha(80),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Icon container at top-left
                        SvgPicture.asset(
                          icon,
                          color: colors.activeButton,
                          height: 24.sp,
                        ),

                        // Badge at top-right
                        if (badge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.greenActive,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              badge!,
                              style: context.theme.fonts.textSmMedium.copyWith(
                                fontSize: 10.sp,
                                color: context.theme.colors.contrastWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Title
                    Text(
                      title,
                      style: context.theme.fonts.textSmSemiBold.copyWith(
                        fontSize: 16.sp,
                        color: context.theme.colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      description,
                      style: context.theme.fonts.textSmSemiBold.copyWith(
                        fontSize: 12.sp,
                        color: context.theme.colors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (badge == null)
                Icon(
                  Icons.arrow_forward_ios,
                  color: isEnabled ? Colors.grey[400] : Colors.grey[300],
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
