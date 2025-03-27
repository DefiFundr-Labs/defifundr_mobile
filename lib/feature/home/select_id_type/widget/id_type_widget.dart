import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IdTypeWidget extends StatelessWidget {
  const IdTypeWidget({
    super.key,
    required this.title,
    required this.onTap
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black100,
                ),
              ),
              SvgPicture.asset(AppAssets.arrowRightCurve)
            ],
          ),
        ),
      ),
    );
  }
}
