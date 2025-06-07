import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/app_styles/app_text_styles.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/onboarding_checklist/onboarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingChecklistScreen extends StatelessWidget {
  final String userType; // "Freelancer" or "Contractor"
  final List<OnboardingStep> steps = [
    OnboardingStep(
      title: 'Verify your identity',
      iconAsset: 'assets/svgs/identity.svg',
      isDone: false,
    ),
    OnboardingStep(
      title: 'Provide your BVN',
      iconAsset: 'assets/svgs/bank.svg',
      isDone: false,
    ),
    OnboardingStep(
      title: 'Add tax info for compliance',
      iconAsset: 'assets/svgs/scale.svg',
      isDone: false,
    ),
    OnboardingStep(
      title: 'Fund wallet with tokens',
      iconAsset: 'assets/svgs/wallet.svg',
      isDone: false,
    ),
  ];

  OnboardingChecklistScreen({
    super.key,
    required this.userType,
  });

  bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final completedSteps = steps.where((step) => step.isDone).length;
    // final progress = completedSteps / steps.length;
    final progress = 0.2;

    // Pick palette based on theme
    final palette = isDark(context) ? AppColorDark : AppColors;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 36,
              ),
              color: palette.textPrimary,
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Onboarding Checklist",
                    style: AppTextStyles.heading1.copyWith(
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "You must complete all steps to fully activate your account.",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ✅ Progress bar
                  Row(
                    children: [
                      Text(
                        "${(progress * 100).round()}%",
                        style: AppTextStyles.bodyBold.copyWith(
                          color: palette.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          color: palette.brandDefault,
                          backgroundColor: palette.grayQuaternary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // User type section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.fillTertiary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: palette.brandDefault.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/person.svg',
                          width: 26,
                          height: 26,
                          color: palette.grayQuaternary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Create ${userType.toLowerCase()} account",
                            style: TextStyle(
                              color: palette.grayTertiary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            color: palette.greenFill,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: palette.greenDefault,
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: AppTextStyles.caption.copyWith(
                              color: palette.greenDefault,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Checklist Steps
                  ...steps.map((step) {
                    final isDisabled = step.isDone;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Opacity(
                        opacity: isDisabled ? 0.5 : 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: palette.fillTertiary,
                          ),
                          child: ListTile(
                            tileColor: palette.surfaceCard,
                            leading: SvgPicture.asset(
                              step.iconAsset,
                              width: 26,
                              height: 26,
                              color: palette.grayPrimary,
                            ),
                            title: Text(
                              step.title
                                  .replaceAll('{type}', userType.toLowerCase()),
                              style: AppTextStyles.bodySemiBold.copyWith(
                                color: palette.textPrimary,
                              ),
                            ),
                            trailing: step.isDone
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: palette.greenFill,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Done',
                                      style: AppTextStyles.caption.copyWith(
                                        color: palette.greenDefault,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.chevron_right,
                                    color: palette.grayPrimary,
                                  ),
                            onTap: step.isDone ? null : step.onTap,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
