import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';

import '../widgets/success_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewTimeOffRequestScreen extends StatefulWidget {
  const NewTimeOffRequestScreen({Key? key}) : super(key: key);

  @override
  State<NewTimeOffRequestScreen> createState() =>
      _NewTimeOffRequestScreenState();
}

class _NewTimeOffRequestScreenState extends State<NewTimeOffRequestScreen> {
  final TextEditingController _timeOffTypeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedTimeOffType;
  String? selectedReason;
  DateTime? startDate;
  DateTime? endDate;
  int requestDays = 0;

  final List<String> timeOffTypes = [
    'Paid time off',
    'Unpaid time off',
    'Sick leave',
    'Vacation',
    'Personal leave',
    'Family emergency',
  ];

  final List<String> reasons = [
    'Vacation',
    'Personal leave',
    'Sick leave',
    'Family emergency',
    'Medical appointment',
    'Other',
  ];

  void _calculateRequestDays() {
    if (startDate != null && endDate != null) {
      final difference = endDate!.difference(startDate!).inDays + 1;
      setState(() {
        requestDays = difference > 0 ? difference : 0;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
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

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          _startDateController.text = _formatDate(startDate);
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
            _endDateController.text = '';
            requestDays = 0;
          }
        } else {
          endDate = picked;
          _endDateController.text = _formatDate(endDate);
        }
        _calculateRequestDays();
      });
    }
  }

  void _showDropdown(BuildContext context, List<String> items,
      String? selectedValue, Function(String?) onChanged, String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.theme.colors.strokeSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: context.theme.fonts.heading3SemiBold,
            ),
            const SizedBox(height: 20),
            ...items.map((item) => ListTile(
                  title: Text(item, style: context.theme.fonts.textMdMedium),
                  trailing: selectedValue == item
                      ? Icon(Icons.check,
                          color: context.theme.colors.brandDefault)
                      : null,
                  onTap: () {
                    onChanged(item);
                    context.router.maybePop();
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _submitRequest() {
    if (selectedTimeOffType != null &&
        selectedReason != null &&
        startDate != null &&
        endDate != null &&
        requestDays > 0) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => const SuccessBottomSheet(
          title: 'Time off requested',
          subtitle: 'An email has been sent for your request to be reviewed.',
        ),
      );
    } else {
      AppSnackbar.showError(context, 'Please fill in all required fields');
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB0,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'New time off request',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time off type dropdown
                  AppTextField(
                    controller: _timeOffTypeController,
                    hintText: 'Time off type',
                    readOnly: true,
                    onTap: () => _showDropdown(
                      context,
                      timeOffTypes,
                      selectedTimeOffType,
                      (value) {
                        setState(() {
                          selectedTimeOffType = value;
                          _timeOffTypeController.text = value ?? '';
                        });
                      },
                      'Select Time Off Type',
                    ),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: context.theme.colors.textSecondary),
                  ),
                  const SizedBox(height: 20),

                  // Reason dropdown
                  AppTextField(
                    controller: _reasonController,
                    hintText: 'Reason',
                    readOnly: true,
                    onTap: () => _showDropdown(
                      context,
                      reasons,
                      selectedReason,
                      (value) {
                        setState(() {
                          selectedReason = value;
                          _reasonController.text = value ?? '';
                        });
                      },
                      'Select Reason',
                    ),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: context.theme.colors.textSecondary),
                  ),
                  const SizedBox(height: 20),

                  // Start date
                  AppTextField(
                    controller: _startDateController,
                    hintText: 'Start date',
                    readOnly: true,
                    onTap: () => _selectDate(context, true),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        Assets.icons.calendar,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // End date
                  AppTextField(
                    controller: _endDateController,
                    hintText: 'End date',
                    readOnly: true,
                    onTap: () => _selectDate(context, false),
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        Assets.icons.calendar,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Number of request days
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color:
                          context.theme.colors.graySecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'No of request days',
                            style: context.theme.fonts.textMdRegular.copyWith(
                              color: context.theme.colors.textSecondary,
                            ),
                          ),
                        ),
                        Text(
                          requestDays > 0 ? '$requestDays days' : '--',
                          style: context.theme.fonts.textMdSemiBold.copyWith(
                            color: context.theme.colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    controller: _descriptionController,
                    hintText: 'Enter time off description',
                    maxLine: 6,
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Attachment (Optional)',
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.theme.colors.brandFill,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: context.theme.colors.brandStroke,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Click to upload',
                          style: context.theme.fonts.textMdMedium.copyWith(
                            color: context.theme.colors.brandDefaultContrast,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: context.screenWidth(),
                    child: Text.rich(
                      TextSpan(
                        style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary),
                        children: [
                          TextSpan(
                            text: 'Supported formats: ',
                          ),
                          TextSpan(
                              text: 'JPG, PNG, HEIC or PDF. ',
                              style: context.theme.fonts.textSmMedium.copyWith(
                                  color: context.theme.colors.textPrimary)),
                          TextSpan(
                            text: 'Use ',
                          ),
                          TextSpan(
                              text: '.ZIP',
                              style: context.theme.fonts.textSmMedium.copyWith(
                                  color: context.theme.colors.textPrimary)),
                          TextSpan(
                            text: ' to upload multiple files.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: PrimaryButton(
              onPressed: _submitRequest,
              text: 'Submit request',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timeOffTypeController.dispose();
    _reasonController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
