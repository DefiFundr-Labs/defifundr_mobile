import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_icons.dart';

class DeFiRaiseAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? isBack;
  final Widget? leading;

  const DeFiRaiseAppBar({
    this.title,
    this.actions,
    this.isBack = false,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(title ?? '',
          style: context.textTheme.headlineMedium),
      actions: actions,
      leading: isBack!
          ? IconButton(
              icon: SvgPicture.asset(AppIcons.backIcon),
              onPressed: () {
                context.pop();
              },
            )
          : leading,
    );
  }
}
