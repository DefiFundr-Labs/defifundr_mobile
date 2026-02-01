import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/expense_submitted_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _expenseController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Software & Tools';
  final List<String> _categories = [
    'Software & Tools',
    'Office Supplies',
    'Travel',
    'Marketing',
    'Equipment'
  ];

  // Add attachment state
  String? _attachmentPath;
  String? _attachmentName;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _expenseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would save the expense here
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
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Add expense',
          actions: [],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name field
            _buildTextField(
              context: context,
              label: 'Expense name',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter expense name';
                }
                return null;
              },
            ),

            SizedBox(height: 16.h),

            _buildDropdownField(
              context: context,
              label: 'Category',
              value: _selectedCategory,
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            SizedBox(height: 16.h),

            _buildTextField(
              context: context,
              label: 'Expense date',
              controller: _expenseController,
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter expense date';
                }
                return null;
              },
              suffixType: SuffixType.customIcon,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(
                  Assets.icons.calendar,
                  width: 20.w,
                  height: 20.h,
                  color: context.theme.colors.textSecondary,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Amount field
            _buildTextField(
              context: context,
              label: 'Amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),

            // Description field
            _buildTextField(
              context: context,
              label: '',
              controller: _descriptionController,
              hintText: 'Enter expense description',
              alwaysShowLabelAndHint: true,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),

            SizedBox(height: 24.h),

            // Attachment section - Now included in the form
            _buildAttachmentSection(context),

            // SizedBox(height: 24.h),
            SizedBox(height: 8.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Supported formats: ',
                    style: context.theme.fonts.textBaseRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'JPG, PNG, HEIC or PDF',
                    style: context.theme.fonts.textMdBold.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '; Max file size: ',
                    style: context.theme.fonts.textBaseRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '10MB',
                    style: context.theme.fonts.textMdBold.copyWith(
                      color: context.theme.colors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(context),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    String? label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    bool? alwaysShowLabelAndHint = false,
    SuffixType? suffixType,
    String? Function(String?)? validator,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          labelText: label,
          controller: controller,
          suffixIcon: suffixIcon,
          suffixType: suffixType ?? SuffixType.none,
          validate: true,
          maxLine: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          alwaysShowLabelAndHint: alwaysShowLabelAndHint ?? false,
          hintText: label!.isEmpty ? hintText : 'Enter $label',
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    final categoryController = TextEditingController(text: value);

    return AppTextField(
      controller: categoryController,
      validate: true,
      labelText: "Category",
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SvgPicture.asset(
          Assets.icons.arrowDown,
          width: 6.w,
          height: 6.h,
          color: context.theme.colors.textSecondary,
        ),
      ),
      suffixType: SuffixType.customIcon,
      keyboardType: TextInputType.text,
      readOnly: true,
      onTap: () {
        _showCategoryBottomSheet(context, items, onChanged);
      },
      alwaysShowLabelAndHint: false,
    );
  }

  void _showCategoryBottomSheet(
    BuildContext context,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? context.theme.colors.contrastWhite
              : context.theme.colors.bgB1,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.theme.colors.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Category',
                    style: context.theme.fonts.heading3SemiBold.copyWith(
                      fontSize: 18.sp,
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.router.maybePop(),
                    child: Icon(
                      Icons.close,
                      color: context.theme.colors.textSecondary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Category list
            ...items.map((item) => _buildCategoryItem(
                  context,
                  item,
                  item == _selectedCategory,
                  () {
                    setState(() {
                      _selectedCategory = item;
                    });
                    onChanged(item);
                    context.router.maybePop();
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String category,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.colors.brandDefault.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: context.theme.colors.brandDefault)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: context.theme.fonts.textMdRegular.copyWith(
                fontSize: 14.sp,
                color: isSelected
                    ? context.theme.colors.brandDefault
                    : context.theme.colors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: context.theme.colors.brandDefault,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachment (Optional)',
          style: context.theme.fonts.textMdSemiBold.copyWith(
            fontSize: 14.sp,
            color: context.theme.colors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        InkWell(
          onTap: () {
            _handleFileUpload();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
                border: Border.all(
                  color: context.theme.colors.brandDefault.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
                color: _attachmentPath != null
                    ? context.theme.colors.brandDefault.withOpacity(0.05)
                    : context.theme.colors.brandStroke),
            child: Column(
              children: [
                Text(
                  _attachmentPath != null
                      ? _attachmentName ?? 'File uploaded'
                      : 'Click to upload',
                  style: context.theme.fonts.textMdMedium.copyWith(
                    color: _attachmentPath != null
                        ? context.theme.colors.brandDefault
                        : context.theme.colors.brandDefault,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleFileUpload() async {
    // In a real implementation, you would use file_picker or image_picker
    // For now, we'll simulate file selection

    // Example using file_picker (you need to add the dependency):
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'jpeg', 'png', 'heic', 'pdf'],
    // );

    // if (result != null) {
    //   PlatformFile file = result.files.first;
    //
    //   // Check file size (10MB = 10 * 1024 * 1024 bytes)
    //   if (file.size <= 10 * 1024 * 1024) {
    //     setState(() {
    //       _attachmentPath = file.path;
    //       _attachmentName = file.name;
    //     });
    //   } else {
    //     // Show error message for file too large
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('File size must be less than 10MB')),
    //     );
    //   }
    // }

    // For demo purposes, simulate a file upload
    setState(() {
      _attachmentPath = '/path/to/file';
      _attachmentName = 'receipt_example.pdf';
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: PrimaryButton(
        text: 'Submit request',
        onPressed: _submitExpense,
      ),
    );
  }
}
