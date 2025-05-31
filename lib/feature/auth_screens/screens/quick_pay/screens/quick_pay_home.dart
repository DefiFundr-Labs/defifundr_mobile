import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickPayHomeScreen extends StatefulWidget {
  const QuickPayHomeScreen({super.key});

  @override
  State<QuickPayHomeScreen> createState() => _QuickPayHomeScreenState();
}

class _QuickPayHomeScreenState extends State<QuickPayHomeScreen> {
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
                        'Quickpay',
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
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            width: 283,
                            child: TextField(
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5,
                                letterSpacing: 0.0,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  height: 1.5,
                                  letterSpacing: 0.0,
                                  color: AppColors.textTertiary,
                                ),
                                filled: true,
                                fillColor: AppColors.bgB1Base,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                prefixIcon: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, right: 8),
                                  child: SvgPicture.asset(
                                    AppAssets.magnifyingGlass,
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.strokeSecondary,
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.strokeSecondary,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.strokeSecondary,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.bgB1Base,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.strokeSecondary,
                                width: 0.5,
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppAssets.filterIcon,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.emptyQuickpayIcon,
                                  width: 200,
                                  height: 200,
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Text(
                                    'No quickpay activity yet.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'Your quickpay activity will show up here once you receive one.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BrandButton(
                text: "Receive payment",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
