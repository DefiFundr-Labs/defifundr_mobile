import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color resolveColor({
  required BuildContext context,
  required Color lightColor,
  required Color darkColor,
}) {
  return Theme.of(context).brightness == Brightness.dark
      ? darkColor
      : lightColor;
}

SvgPicture resolveSvg({
  required BuildContext context,
  required String lightSvg,
  required String darkSvg,
}) {
  return SvgPicture.asset(
    Theme.of(context).brightness == Brightness.dark ? darkSvg : lightSvg,
  );
}
