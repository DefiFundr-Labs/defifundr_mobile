import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/components/radio_selection_card.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/agreement_file_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/uploaded_file_card.dart';

class ComplianceStep extends StatefulWidget {
  final String? agreementType;
  final TextEditingController additionalTermsController;
  final ValueChanged<String> onAgreementTypeChanged;
  final VoidCallback onNext;

  const ComplianceStep({
    Key? key,
    required this.agreementType,
    required this.additionalTermsController,
    required this.onAgreementTypeChanged,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ComplianceStep> createState() => _ComplianceStepState();
}

class _ComplianceStepState extends State<ComplianceStep> {
  bool _isFileUploaded = false;

  @override
  Widget build(BuildContext context) {
    final agreementType = widget.agreementType;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Agreement', style: context.theme.fonts.textBaseMedium),
                  SizedBox(height: 20.h),
                  RadioSelectionCard(
                    titleStyle: context.theme.fonts.textMdRegular,
                    title: 'Use our standard agreement',
                    isSelected: agreementType == 'Standard',
                    onTap: () => widget.onAgreementTypeChanged('Standard'),
                  ),
                  SizedBox(height: 8.h),
                  RadioSelectionCard(
                    titleStyle: context.theme.fonts.textMdRegular,
                    title: 'Use your own custom agreement',
                    isSelected: agreementType == 'Custom',
                    onTap: () => widget.onAgreementTypeChanged('Custom'),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'For custom uploaded contracts, project details will appear in an addendum section attached to your PDF file.',
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (agreementType == 'Standard') ...[
                    Text('Agreement file',
                        style: context.theme.fonts.textMdRegular),
                    SizedBox(height: 8.h),
                    const AgreementFileCard(),
                    SizedBox(height: 20.h),
                  ],
                  if (agreementType == 'Custom') ...[
                    Text(
                      _isFileUploaded ? 'Uploaded file' : 'Upload your file',
                      style: context.theme.fonts.textMdRegular,
                    ),
                    SizedBox(height: 8.h),
                    if (!_isFileUploaded) ...[
                      PrimaryButton(
                        borderRadius: BorderRadius.circular(12.r),
                        borderColor: context.theme.colors.brandStroke,
                        color: context.theme.colors.brandFill,
                        textColor: context.theme.colors.brandDefaultContrast,
                        text: 'Click to upload',
                        onPressed: () => setState(() => _isFileUploaded = true),
                      ),
                      SizedBox(height: 8.h),
                      _buildUploadHelperText(context),
                    ] else ...[
                      UploadedFileCard(
                        fileName: 'File name',
                        onDelete: () => setState(() => _isFileUploaded = false),
                      ),
                    ],
                    SizedBox(height: 20.h),
                  ],
                  Text('Additional terms (optional)',
                      style: context.theme.fonts.textBaseMedium),
                  SizedBox(height: 20.h),
                  Text(
                    'Add additional terms to cover special scenarios. These terms will be applied to the Service Agreement Template or uploaded contract and override existing contract terms.',
                    style:
                        context.theme.fonts.textSmRegular.copyWith(height: 1.4),
                  ),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: widget.additionalTermsController,
                    hintText: 'Add terms here',
                    maxLine: 6,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                  ),
                ],
              ),
            ),
          ),
          PrimaryButton(
            text: 'Continue',
            onPressed: widget.onNext,
          ),
        ],
      ),
    );
  }

  Widget _buildUploadHelperText(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: context.theme.fonts.textSmMedium.copyWith(
          color: context.theme.colors.textSecondary,
        ),
        children: [
          const TextSpan(text: 'Supported format: '),
          TextSpan(
            text: 'PDF',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colors.textPrimary),
          ),
          const TextSpan(text: '; Max file size: '),
          TextSpan(
            text: '10MB',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
