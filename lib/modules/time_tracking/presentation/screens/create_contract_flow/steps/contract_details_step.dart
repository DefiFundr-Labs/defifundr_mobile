import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/create_template_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractDetailsStep extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController jobRoleController;
  final TextEditingController workScopeTemplateController;
  final TextEditingController explanationController;
  final VoidCallback onNext;

  const ContractDetailsStep({
    Key? key,
    required this.titleController,
    required this.jobRoleController,
    required this.workScopeTemplateController,
    required this.explanationController,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ContractDetailsStep> createState() => _ContractDetailsStepState();
}

class _ContractDetailsStepState extends State<ContractDetailsStep> {
  final List<String> _jobRoles = [
    'Product Designer',
    'Graphic Designer',
    'Visual Designer',
    'Motion Graphics Designer',
    'Brand Identity Designer',
    'Creative Director',
    'Frontend Developer',
    'Backend Developer',
  ];

  final List<String> _workScopeTemplates = [
    'Product Designer',
    'Graphic Designer',
    'Visual Designer',
    'Motion Graphics Designer',
    'Brand Identity Designer',
    'Creative Director',
    'Frontend Developer',
    'Backend Developer',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    keyboardType: TextInputType.text,
                    controller: widget.titleController,
                    hintText: 'Title',
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: widget.jobRoleController,
                    labelText: 'Job role',
                    hintText: 'Job role',
                    suffixType: SuffixType.defaultt,
                    readOnly: true,
                    onTap: () => _showJobRoleSelection(context),
                  ),
                  SizedBox(height: 20.h),
                  Text('Work scope', style: context.theme.fonts.textMdMedium),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: widget.workScopeTemplateController,
                    labelText: 'Select template (optional)',
                    hintText: 'Select template (optional)',
                    suffixType: SuffixType.defaultt,
                    readOnly: true,
                    onTap: () => _showWorkScopeSelection(context),
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    controller: widget.explanationController,
                    hintText: 'Explanation of work scope',
                    maxLine: 6,
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

  void _showJobRoleSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet(
        title: 'Select Job Role',
        items: _jobRoles,
        onSelected: (role) {
          widget.jobRoleController.text = role;
          context.router.maybePop();
        },
      ),
    );
  }

  void _showWorkScopeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet(
        title: 'Work scope templates',
        items: _workScopeTemplates,
        showSearch: true,
        actionButtonText: 'Create new template',
        onActionButtonPressed: () {
          context.router.maybePop();
          _showCreateTemplateBottomSheet(context);
        },
        onSelected: (template) {
          widget.workScopeTemplateController.text = template;
          context.maybePop();
        },
      ),
    );
  }

  void _showCreateTemplateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateTemplateBottomSheet(),
    );
  }
}
