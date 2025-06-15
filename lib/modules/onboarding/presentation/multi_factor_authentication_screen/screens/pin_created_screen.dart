import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared/common_ui/buttons/primary_button.dart';

class PinCreatedScreen extends StatelessWidget {
  const PinCreatedScreen({super.key});

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
                  color: colors.greenFill,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/pinCreated.svg',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'PIN Code Created',
                style: fonts.heading3SemiBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'You have successfully created your PIN code.',
                style: fonts.textMdRegular.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/enable-face-id');
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
