import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/shared/common/buttons/primary_button.dart';
import '../../../../../core/shared/common/buttons/small_button.dart';

@RoutePage()
class EnablePushNotificationScreen extends StatelessWidget {
  const EnablePushNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB0 
          : colors.bgB1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: colors.blueFill,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Enable Push Notifications',
                style: fonts.heading3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'For instant updates, important announcements.',
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              PrimaryButton(
                text: 'Enable',
                onPressed: () {
                 context.router.popUntilRoot();              
                },
              ),
              const SizedBox(height: 12),
              SmallButton(
                text: 'Skip',
                onPressed: () {
                  context.router.popUntilRoot();                      
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
