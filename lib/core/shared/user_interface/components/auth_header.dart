import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../constants/size.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Config.h2(context).copyWith(
            fontSize: 26,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Config.b3(context).copyWith(
            color: context.theme.primaryColorDark,
          ),
        ),
      ],
    );
  }
}
