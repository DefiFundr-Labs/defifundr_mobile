import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import '../../data/models/time_off_detail.dart';
import '../widgets/success_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class RequestChangeScreen extends StatefulWidget {
  final TimeOffDetail timeOffDetail;

  const RequestChangeScreen({
    Key? key,
    required this.timeOffDetail,
  }) : super(key: key);

  @override
  State<RequestChangeScreen> createState() => _RequestChangeScreenState();
}

class _RequestChangeScreenState extends State<RequestChangeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _reasonForChangeController = TextEditingController();
  String? selectedTimeOffType;
  String? selectedReason;
  DateTime? startDate;
  DateTime? endDate;
  int requestDays = 0;
  bool hasAttachment = true;

  final List<String> timeOffTypes = [
    'Paid time off',
    'Unpaid time off',
    'Sick leave',
    'Vacation',
    'Personal leave',
    'Family emergency',
  ];

  final List<String> reasons = [
    'Annual leave',
    'Vacation',
    'Personal leave',
    'Sick leave',
    'Family emergency',
    'Medical appointment',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    selectedTimeOffType = widget.timeOffDetail.type;
    selectedReason = widget.timeOffDetail.reason;
    startDate = widget.timeOffDetail.startDate;
    endDate = widget.timeOffDetail.endDate;
    requestDays = widget.timeOffDetail.totalDays;
    _descriptionController.text = widget.timeOffDetail.description;
  }

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
      initialDate: isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
            requestDays = 0;
          }
        } else {
          endDate = picked;
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
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(title, style: context.theme.fonts.heading3SemiBold),
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
          ],
        ),
      ),
    );
  }

  void _submitChange() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessBottomSheet(
        title: 'Change request submitted',
        subtitle: 'Your change request has been submitted\nfor approval.',
        icon: Icon(Icons.change_circle_outlined, size: 32, color: context.theme.colors.orangeDefault),
        iconBackgroundColor: context.theme.colors.orangeDefault.withValues(alpha: 0.1),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  Widget _buildField(
      {required String label,
      required String value,
      required Widget suffixIcon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB1,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color:
                  context.theme.colors.strokeSecondary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: context.theme.fonts.textXsMedium
                          .copyWith(color: context.theme.colors.textTertiary)),
                  const SizedBox(height: 4),
                  Text(value,
                      style: context.theme.fonts.textMdMedium
                          .copyWith(color: context.theme.colors.textPrimary)),
                ],
              ),
            ),
            suffixIcon,
          ],
        ),
      ),
    );
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
          title: 'Request change',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField(
                    label: 'Time off type',
                    value: selectedTimeOffType ?? 'Select type',
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: context.theme.colors.textSecondary),
                    onTap: () => _showDropdown(
                        context,
                        timeOffTypes,
                        selectedTimeOffType,
                        (val) => setState(() => selectedTimeOffType = val),
                        'Select Time Off Type'),
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    label: 'Reason',
                    value: selectedReason ?? 'Select reason',
                    suffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: context.theme.colors.textSecondary),
                    onTap: () => _showDropdown(
                        context,
                        reasons,
                        selectedReason,
                        (val) => setState(() => selectedReason = val),
                        'Select Reason'),
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    label: 'Start date',
                    value: _formatDate(startDate),
                    suffixIcon: Icon(Icons.calendar_today_outlined,
                        color: context.theme.colors.textSecondary, size: 20),
                    onTap: () => _selectDate(context, true),
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    label: 'End date',
                    value: _formatDate(endDate),
                    suffixIcon: Icon(Icons.calendar_today_outlined,
                        color: context.theme.colors.textSecondary, size: 20),
                    onTap: () => _selectDate(context, false),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.theme.colors.strokeSecondary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No of request days',
                          style: context.theme.fonts.textSmMedium.copyWith(
                              color: context.theme.colors.textSecondary),
                        ),
                        Text(
                          '$requestDays days',
                          style: context.theme.fonts.textSmSemiBold.copyWith(
                              color: context.theme.colors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(controller: _descriptionController, maxLine: 6),
                  const SizedBox(height: 24),
                  Text(
                    'Attachment (Optional)',
                    style: context.theme.fonts.textMdMedium
                        .copyWith(color: context.theme.colors.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  if (hasAttachment)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB1,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: context.theme.colors.strokeSecondary
                                .withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icons.file,
                            colorFilter: ColorFilter.mode(
                                context.theme.colors.brandDefault,
                                BlendMode.srcIn),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'File name',
                              style: context.theme.fonts.textSmMedium.copyWith(
                                  color: context.theme.colors.textPrimary),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                hasAttachment = false;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: SvgPicture.asset(
                              Assets.icons.trash,
                              colorFilter: ColorFilter.mode(
                                  context.theme.colors.redDefault,
                                  BlendMode.srcIn),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    'Reason for change',
                    style: context.theme.fonts.textMdMedium
                        .copyWith(color: context.theme.colors.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _reasonForChangeController,
                    maxLine: 6,
                    hintText: 'Enter your change request...',
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16),
            child: PrimaryButton(
              onPressed: _submitChange,
              text: 'Submit change',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _reasonForChangeController.dispose();
    super.dispose();
  }
}
