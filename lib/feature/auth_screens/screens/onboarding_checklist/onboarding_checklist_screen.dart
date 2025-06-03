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

  @override
  Widget build(BuildContext context) {
    final completedSteps = steps.where((step) => step.isDone).length;
    // final progress = completedSteps / steps.length;
    final progress = 0.2;

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
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 16),

                  const SizedBox(height: 8),
                  const Text(
                    "Onboarding Checklist",
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "You must complete all steps to fully activate your account.",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ✅ Progress bar
                  Row(
                    children: [
                      Text(
                        "${(progress * 100).round()}%",
                        style: AppTextStyles.bodyBold,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          color: AppColors.brandDefault,
                          backgroundColor: AppColors.grayQuaternary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 🆕 New user type section with person SVG
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.fillTertiary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.brandDefault.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/person.svg',
                          width: 26,
                          height: 26,
                          color:
                              Colors.grey[500], // keep as is, not in AppColors
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            "Create ${userType.toLowerCase()} account",
                            style: TextStyle(
                                color: Colors
                                    .grey[600]), // keep as is, not in AppColors
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.greenFill,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.greenDefault,
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.greenDefault),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ✅ Checklist Steps
                  ...steps.map((step) {
                    final isDisabled = step.isDone;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Opacity(
                        opacity: isDisabled ? 0.5 : 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.fillTertiary,
                          ),
                          child: ListTile(
                            tileColor: AppColors.surfaceCard,
                            leading: SvgPicture.asset(
                              step.iconAsset,
                              width: 26,
                              height: 26,
                              color: AppColors.grayPrimary,
                            ),
                            title: Text(
                              step.title
                                  .replaceAll('{type}', userType.toLowerCase()),
                              style: AppTextStyles.bodySemiBold,
                            ),
                            trailing: step.isDone
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.greenFill,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Done',
                                      style: AppTextStyles.caption.copyWith(
                                          color: AppColors.greenDefault),
                                    ),
                                  )
                                : const Icon(Icons.chevron_right),
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
