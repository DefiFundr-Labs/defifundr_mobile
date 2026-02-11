import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'More',
          style: context.theme.fonts.heading2Bold.copyWith(
            color: context.theme.colors.textPrimary,
            fontFamily: 'HankenGrotesk',
          ),
        ),
      ),
      body: const Center(
        child: Text('Coming soon'),
      ),
    );
  }
}
