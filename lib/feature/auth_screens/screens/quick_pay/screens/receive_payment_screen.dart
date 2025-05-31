import 'dart:ui';

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceivePaymentScreen extends StatefulWidget {
  const ReceivePaymentScreen({super.key});

  @override
  State<ReceivePaymentScreen> createState() => _ReceivePaymentScreenState();
}

class _ReceivePaymentScreenState extends State<ReceivePaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgB0Base,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.contrastBlack),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.questionSvg,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Need Help?',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24 / 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Receive Payment',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'HankenGrotesk',
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Receive crypto payments instantly via address, QR code, or payment link.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8 * 1.5),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BrandButton(
                text: "Continue",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
