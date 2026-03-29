import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../data/models/contract.dart';
import '../widgets/success_bottom_sheet.dart';

@RoutePage()
class AddMilestoneScreen extends StatefulWidget {
  final PayCycleContract contract;

  const AddMilestoneScreen({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  State<AddMilestoneScreen> createState() => _AddMilestoneScreenState();
}

class _AddMilestoneScreenState extends State<AddMilestoneScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.theme.colors.brandDefault,
              onPrimary: context.theme.colors.contrastWhite,
              onSurface: context.theme.colors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dueDateController.text = DateFormat('d MMM yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB0,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3Bold,
          isBack: true,
          title: 'Add a milestone',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _nameController,
                    hintText: 'Milestone name',
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _descriptionController,
                    hintText: 'Milestone description',
                    maxLine: 8,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _dueDateController,
                    hintText: 'Estimated due date',
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        Assets.icons.calendar,
                        color: context.theme.colors.textSecondary,
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _amountController,
                    hintText: 'Amount',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Text('Attachment (Optional)',
                      style: context.theme.fonts.textMdMedium),
                  const SizedBox(height: 8),
                  _buildUploadSection(context),
                  const SizedBox(height: 8),
                  _buildFormatHelperText(context),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
            child: PrimaryButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const SuccessBottomSheet(
                    actionType: SuccessActionType.milestoneAdded,
                  ),
                );
              },
              text: 'Add milestone',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    return SecondaryButton(
      text: 'Click to upload',
      onPressed: () {},
      backgroundColor: context.theme.colors.brandFill,
      textColor: context.theme.colors.brandDefault,
      borderColor: context.theme.colors.brandStroke,
      borderRadius: BorderRadius.circular(8.r),
      fixedSize: Size(double.infinity, 64.h),
    );
  }

  Widget _buildFormatHelperText(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: context.theme.fonts.textSmRegular
            .copyWith(color: context.theme.colors.textSecondary),
        children: [
          const TextSpan(text: 'Supported formats: '),
          TextSpan(
              text: 'JPG, PNG, HEIC or PDF; ',
              style: context.theme.fonts.textSmMedium
                  .copyWith(color: context.theme.colors.textPrimary)),
          const TextSpan(text: 'Max file size: '),
          TextSpan(
              text: '10MB',
              style: context.theme.fonts.textSmMedium
                  .copyWith(color: context.theme.colors.textPrimary)),
        ],
      ),
    );
  }
}
