import 'package:defifundr_mobile/core/constants/fonts.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionItem extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final VoidCallback onTap;
  final bool hasBorder;
  final Color borderColor;

  const ActionItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.onTap,
    this.hasBorder = false,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 62,
        width: 168,
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(16),
          border: hasBorder ? Border.all(color: borderColor) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: backgroundColor, shape: BoxShape.circle),
                child: SvgPicture.asset(
                  icon,
                  width: 10,
                  height: 10,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: DefiFundrFonts.h3(context)
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
