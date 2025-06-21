import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProcessingBvnRequestScreen extends StatelessWidget {
  const ProcessingBvnRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    resolveSvg(
                      context: context,
                      lightSvg: AppAssets.bvnProcessing,
                      darkSvg: AppAssets.bvnProcessingDark,
                    ),
                    const SizedBox(height: 40),
                    Text('Processing Request',
                        style: context.theme.fonts.heading2Bold
                            .copyWith(color: context.theme.colors.textPrimary)),
                    const SizedBox(height: 12),
                    Text(
                      'You’ll be notified by email once your fiat account setup is complete.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: context.theme.colors.textSecondary),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: BrandButton(
                text: "Back to checklist",
                onPressed: () =>
                    context.pushNamed(RouteConstants.taxInformationScreen)),
          ),
        ],
      ),
    );
  }
}
