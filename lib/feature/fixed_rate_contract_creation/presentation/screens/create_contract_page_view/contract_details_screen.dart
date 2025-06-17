import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/jobs_list.dart';
import 'package:flutter/material.dart';

class ContractDetailsScreen extends StatefulWidget {
  const ContractDetailsScreen({super.key});

  @override
  State<ContractDetailsScreen> createState() => _ContractDetailsScreenState();
}

class _ContractDetailsScreenState extends State<ContractDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _jobRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: 'Title',
              controller: _titleController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            AppTextField(
              controller: _jobRoleController,
              label: 'Job role',
              isDropdown: true,
              dropDownSheetChild: JobTemplateBottomSheet(
                onSelect: (value) {
                  _jobRoleController.text = value;
                },
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            Text("Work scope", style: context.theme.fonts.textMdMedium),
            SizedBox(height: 8),
            AppTextField(
              label: 'Select template (optional)',
              isDropdown: true,
              dropDownSheetChild: CreateJobTemplate(
                onSelect: (value) {},
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
              label: 'Explanation of work scope',
              maxLines: 7,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}

class JobTemplateBottomSheet extends StatefulWidget {
  final void Function(String) onSelect;

  const JobTemplateBottomSheet({super.key, required this.onSelect});

  @override
  State<JobTemplateBottomSheet> createState() => _JobTemplateBottomSheetState();
}

class _JobTemplateBottomSheetState extends State<JobTemplateBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Work scope templates', style: context.theme.fonts.heading2Bold),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Search',
            controller: _searchController,
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.borderGrey,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: jobsList.length,
              itemBuilder: (_, index) {
                final job = jobsList[index];
                return GestureDetector(
                  onTap: () {
                    widget.onSelect(job);
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        job,
                        style: context.theme.fonts.textMdMedium,
                      )),
                );
              },
            ),
          ),
          BrandButton(text: "Create new template", onPressed: () {}),
        ],
      ),
    );
  }
}

class CreateJobTemplate extends StatefulWidget {
  final void Function(String) onSelect;

  const CreateJobTemplate({super.key, required this.onSelect});

  @override
  State<CreateJobTemplate> createState() => _CreateJobTemplateState();
}

class _CreateJobTemplateState extends State<CreateJobTemplate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create work scope template',
              style: context.theme.fonts.heading2Bold),
          const SizedBox(height: 12),
          AppTextField(
            label: 'Template name',
            controller: _nameController,
          ),
          Text(
            'Provide a clear name related to the job role.',
            style: context.theme.fonts.textSmRegular
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: AppTextField(
              controller: _explanationController,
              label: 'Explanation of work scope',
              maxLines: 10,
              keyboardType: TextInputType.multiline,
            ),
          ),
          SizedBox(height: 12),
          BrandButton(
              text: "Save template",
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
