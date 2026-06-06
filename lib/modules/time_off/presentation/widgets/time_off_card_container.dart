import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeOffCardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;

  const TimeOffCardContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.constantDefault,
            spreadRadius: -5,
            blurRadius: 1,
            offset: const Offset(0, -1),
          )
        ],
      ),
      child: child,
    );
  }
}
