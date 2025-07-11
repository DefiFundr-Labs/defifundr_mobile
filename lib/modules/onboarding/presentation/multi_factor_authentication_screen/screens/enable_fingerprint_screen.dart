import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared/common_ui/buttons/primary_button.dart';
import '../../../../../core/shared/common_ui/buttons/small_button.dart';

class EnableFingerprintScreen extends StatelessWidget {
  const EnableFingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB0 // Light mode color
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
                    'assets/icons/fingerprint.svg',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Enable Login Using Fingerprint',
                style: fonts.heading3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Experience safe, secure and seamless login using fingerprint.',
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Enable',
                onPressed: () {
                  Navigator.pushNamed(context, '/enable-push');
                },
              ),
              const SizedBox(height: 12),
              SmallButton(
                text: 'Skip',
                onPressed: () {
                  Navigator.pushNamed(context, '/enable-push');
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
