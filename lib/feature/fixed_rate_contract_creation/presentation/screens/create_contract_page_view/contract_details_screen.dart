import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/jobs_list.dart';
import 'package:flutter/material.dart';

class ContractDetailsScreen extends StatefulWidget {
  const ContractDetailsScreen({super.key});

  @override
  State<ContractDetailsScreen> createState() => _ContractDetailsScreenState();
}

class _ContractDetailsScreenState extends State<ContractDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _explanationController.dispose();
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
              label: 'Job role',
              isDropdown: true,
              dropdownItems: jobsList,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            Text("Work scope", style: context.theme.fonts.textMdMedium),
            SizedBox(height: 8),
            AppTextField(
              label: 'Select template (optional)',
              isDropdown: true,
              dropDownSheetChild: JobTemplateBottomSheet(
                onSelect: (value) {},
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
              label: 'Explanation of work scope',
              maxLines: 5,
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
  List<String> jobs = [
    'Product Designer',
    'Graphic Designer',
    'Visual Designer',
    'Motion Graphics Designer',
    'Brand Identity Designer',
    'Creative Director',
    'Frontend Developer',
    'Backend Developer',
  ];

  List<String> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = jobs;
    _searchController.addListener(() {
      setState(() {
        filtered = jobs
            .where((job) => job
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work scope templates',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AppTextField(label: 'Search', controller: _searchController),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final job = filtered[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onSelect(job);
                      Navigator.pop(context);
                    },
                    child: Text(job),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create new template',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
