import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DesignServicesAgreementBottomSheet extends StatelessWidget {
  final VoidCallback onSign;
  const DesignServicesAgreementBottomSheet({super.key, required this.onSign});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB0,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Design Services Agreement',
                        style: context.theme.fonts.textBaseBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text.rich(
                      TextSpan(
                        style: context.theme.fonts.textSmRegular
                            .copyWith(height: 1.5),
                        children: [
                          const TextSpan(
                              text:
                                  'This Design Service Agreement (the "Agreement") is made and entered into on '),
                          TextSpan(
                            text: '21 Dec 2022',
                            style: context.theme.fonts.textSmBold,
                          ),
                          const TextSpan(text: ' by and between '),
                          TextSpan(
                            text: '[Client Name]',
                            style: context.theme.fonts.textSmBold,
                          ),
                          const TextSpan(text: ' ("Client") and '),
                          TextSpan(
                            text: '[Designer name]',
                            style: context.theme.fonts.textSmBold,
                          ),
                          const TextSpan(text: ' ("Contractor").'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    _AgreementSection(
                      title: '1. Purpose',
                      content:
                          'The purpose of this Agreement is to outline the terms and conditions for the branding and web design services to be provided by Contractor to Client.',
                    ),
                    _AgreementSection(
                      title: '2. Scope of work',
                      content:
                          'Contractor will provide the following services to Client:',
                      bullets: const [
                        'Branding services, including brand strategy consultation, logo design, brand guidelines, and any other branding materials as agreed upon by both parties.',
                        'Web design services, including the design and development of a new website for the Client.',
                      ],
                    ),
                    _AgreementSection(
                      title: '3. Deliverables',
                      content:
                          'Contractor will deliver the following to Client:',
                      bullets: const [
                        'A completed, fully-functional website.',
                        'All source files for the website, including design files and code.',
                        'Any branding materials as agreed upon by both parties.',
                      ],
                    ),
                    _AgreementSection(
                      title: '4. Payment and Ongoing costs',
                      content:
                          'The Client will pay the Contractor the total agreed sum, outlined in the project package, for the completion of the scope of work outlined in this Agreement. This fee shall be paid in the following installments',
                      bullets: const [
                        '50% payment due on acceptance of agreement',
                        '25% payment due on completion of brand design work',
                        '25% payment due on completion of web design work',
                      ],
                    ),
                    _AgreementSection(
                      title: '4.1 Ongoing costs',
                      content:
                          'Client will be responsible for any ongoing subscription costs associated with the website, including hosting and any necessary updates or maintenance.',
                    ),
                    _AgreementSection(
                      title: '5. Terms',
                      content:
                          'This Agreement will begin on the date of acceptance and will remain in effect until all services have been completed.',
                    ),
                    _AgreementSection(
                      title: '6. Termination',
                      content:
                          'Either party may terminate this Agreement at any time, for any reason, with written notice to the other party. Upon termination, Contractor will deliver all final deliverables to Client and will be paid for all work completed up to the date of termination.',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
            child: PrimaryButton(
              text: 'Sign contract',
              onPressed: onSign,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgreementSection extends StatelessWidget {
  final String title;
  final String content;
  final List<String>? bullets;

  const _AgreementSection({
    required this.title,
    required this.content,
    this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.theme.fonts.textSmBold),
        SizedBox(height: 6.h),
        Text(
          content,
          style: context.theme.fonts.textSmRegular.copyWith(height: 1.5),
        ),
        if (bullets != null) ...[
          SizedBox(height: 4.h),
          ...bullets!.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 8),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: context.theme.fonts.textSmRegular
                          .copyWith(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        SizedBox(height: 20.h),
      ],
    );
  }
}
