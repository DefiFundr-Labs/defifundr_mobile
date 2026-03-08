import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTemplateBottomSheet extends StatefulWidget {
  const CreateTemplateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateTemplateBottomSheet> createState() =>
      _CreateTemplateBottomSheetState();
}

class _CreateTemplateBottomSheetState extends State<CreateTemplateBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _explanationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text('Create work scope template',
                      style: context.theme.fonts.heading2Bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _nameController,
                    hintText: 'Template name',
                  ),
                  SizedBox(height: 8.h),
                  Text('Provide a clear name related to the job role.',
                      style: context.theme.fonts.textSmRegular
                          .copyWith(color: context.theme.colors.textSecondary)),
                  SizedBox(height: 20.h),
                  AppTextField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    controller: _explanationController,
                    hintText: 'Explanation of work scope',
                    maxLine: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
            child: PrimaryButton(
              text: 'Save template',
              onPressed: () {
                context.router.maybePop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
