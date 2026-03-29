import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/milestone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddEditMilestoneBottomSheet extends StatefulWidget {
  final Milestone? existing;
  final ValueChanged<Milestone> onSave;
  final VoidCallback? onDelete;

  const AddEditMilestoneBottomSheet({
    super.key,
    this.existing,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<AddEditMilestoneBottomSheet> createState() =>
      _AddEditMilestoneBottomSheetState();
}

class _AddEditMilestoneBottomSheetState
    extends State<AddEditMilestoneBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _amountController;
  late final TextEditingController _dueDateController;

  bool get _isEditMode => widget.existing != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existing?.name ?? '');
    _descController =
        TextEditingController(text: widget.existing?.description ?? '');
    _amountController =
        TextEditingController(text: widget.existing?.amount ?? '');
    _dueDateController =
        TextEditingController(text: widget.existing?.dueDate ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _dueDateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  void _save() {
    final milestone = Milestone(
      id: widget.existing?.id ?? const Uuid().v4(),
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      amount: _amountController.text.trim(),
      dueDate: _dueDateController.text.trim(),
    );
    widget.onSave(milestone);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: context.theme.colors.strokePrimary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                _isEditMode ? 'Edit milestone' : 'Add milestone',
                style: context.theme.fonts.heading3Bold,
              ),
            ),
            SizedBox(height: 20.h),
            AppTextField(
              controller: _nameController,
              hintText: 'Milestone name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),
            AppTextField(
              maxLine: 10,
              controller: _descController,
              hintText: 'Milestone description',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),
            AppTextField(
              controller: _amountController,
              hintText: 'Amount',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            AppTextField(
              controller: _dueDateController,
              hintText: 'Due date',
              suffixType: SuffixType.customIcon,
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
                color: context.theme.colors.grayTertiary,
                size: 20,
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            SizedBox(height: 24.h),
            if (_isEditMode)
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                        textColor: context.theme.colors.redDefault,
                        backgroundColor: Colors.transparent,
                        borderColor: context.theme.colors.redDefault,
                        text: 'Delete',
                        onPressed: () {
                          widget.onDelete?.call();
                          Navigator.of(context).pop();
                        }),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Save changes',
                      onPressed: _save,
                    ),
                  ),
                ],
              )
            else
              PrimaryButton(
                text: 'Add milestone',
                onPressed: _save,
              ),
          ],
        ),
      ),
    );
  }
}
