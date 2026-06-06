import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/expense_submitted_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/uploaded_file_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _expenseDateController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  String? _attachmentName;

  static const List<String> _categories = [
    'Software & Tools',
    'Office Supplies',
    'Travel',
    'Marketing',
    'Equipment',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _expenseDateController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      _expenseDateController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectionBottomSheet(
        title: 'Select category',
        items: _categories,
        onSelected: (val) {
          setState(() => _selectedCategory = val as String);
          context.router.maybePop();
        },
      ),
    );
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      showExpenseSubmittedBottomSheet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3Bold,
          isBack: true,
          title: 'Add expense',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  AppTextField(
                    controller: _nameController,
                    labelText: 'Expense name',
                    hintText: 'Enter expense name',
                    errorTextOnValidation: 'Please enter expense name',
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller:
                        TextEditingController(text: _selectedCategory ?? ''),
                    labelText: 'Category',
                    hintText: 'Select category',
                    suffixType: SuffixType.defaultt,
                    readOnly: true,
                    errorTextOnValidation: 'Please select a category',
                    onTap: _showCategoryPicker,
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _expenseDateController,
                    labelText: 'Expense date',
                    hintText: 'Select date',
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SvgPicture.asset(
                        Assets.icons.calendar,
                        width: 20,
                        height: 20,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    readOnly: true,
                    errorTextOnValidation: 'Please select expense date',
                    onTap: _selectDate,
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _amountController,
                    labelText: 'Amount',
                    hintText: 'Enter amount',
                    keyboardType: TextInputType.number,
                    customValidator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter amount';
                      if (double.tryParse(value) == null) return 'Please enter a valid amount';
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: _descriptionController,
                    hintText: 'Enter expense description',
                    maxLine: 7,
                    alwaysShowLabelAndHint: true,
                    errorTextOnValidation: 'Please enter a description',
                  ),
                  SizedBox(height: 20.h),
                  Text('Attachment (Optional)',
                      style: context.theme.fonts.textMdMedium),
                  SizedBox(height: 8.h),
                  if (_attachmentName != null)
                    UploadedFileCard(
                      fileName: _attachmentName!,
                      onDelete: () => setState(() => _attachmentName = null),
                    )
                  else
                    GestureDetector(
                      onTap: () => setState(
                          () => _attachmentName = 'receipt_example.pdf'),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: context.theme.colors.brandFill,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.theme.colors.brandStroke,
                          ),
                        ),
                        child: Text(
                          'Click to upload',
                          textAlign: TextAlign.center,
                          style: context.theme.fonts.textMdMedium.copyWith(
                            color: context.theme.colors.brandDefaultContrast,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 8.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Supported formats: ',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: 'JPG, PNG, HEIC or PDF',
                          style: context.theme.fonts.textSmMedium,
                        ),
                        TextSpan(
                          text: '; Max file size: ',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        TextSpan(
                          text: '10MB',
                          style: context.theme.fonts.textSmMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
            child: PrimaryButton(
              onPressed: _submitExpense,
              text: 'Add expense',
            ),
          ),
        ],
      ),
    );
  }
}
