import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.color,
    required this.text,
    this.isActive = true,
    this.gradient,
    this.icon,
    this.iconRtr,
    this.iconSize,
    this.borderRadius,
    required this.textColor,
    this.textSize = 16,
    this.height = 48,
    this.width,
    this.borderColor,
    this.isRounded = false,
    this.preserveIconColor = false,
    required this.onTap,
  });
  final Color? color;
  final String text;
  final bool? isActive;
  final bool? isRounded;
  final String? icon;
  final String? iconRtr;
  final double? iconSize;
  final double? borderRadius;
  final Color textColor;
  final double? textSize, height, width;
  final bool? gradient;
  final void Function()? onTap;
  final Color? borderColor;
  final bool preserveIconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 10.sp),
      child: Container(
        height: height ?? 56.sp,
        decoration: BoxDecoration(
          color: isActive! ? color : Theme.of(context).colors.textTertiary,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            width: width ?? 0.5.sp,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: isActive == true ? onTap : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconRtr != null)
                SvgPicture.asset(
                  iconRtr!,
                  height: iconSize ?? 16.sp,
                  width: iconSize ?? 16.sp,
                  color: preserveIconColor ? null : textColor,
                )
              else
                const SizedBox(),
              const HorizontalMargin(5),
              Text(
                text,
                style: Config.b1(context).copyWith(
                  color: isActive! ? textColor : context.theme.scaffoldBackgroundColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const HorizontalMargin(7),
              if (icon != null)
                SvgPicture.asset(
                  icon!,
                  height: iconSize ?? 16.sp,
                  width: iconSize ?? 16.sp,
                  color: preserveIconColor ? null : textColor,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
