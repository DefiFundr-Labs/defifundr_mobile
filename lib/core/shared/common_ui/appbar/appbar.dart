import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_icons.dart';

class DeFiRaiseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? isBack;
  final Widget? leading;
  final bool centerTitle;
  const DeFiRaiseAppBar({
    this.title,
    this.actions,
    this.centerTitle = true,
    this.isBack = false,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: Text(title ?? '', style: context.textTheme.headlineMedium),
      actions: actions,
      leading: isBack!
          ? IconButton(
              icon: SvgPicture.asset(
                AppIcons.backIcon,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                context.pop();
              },
            )
          : leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
