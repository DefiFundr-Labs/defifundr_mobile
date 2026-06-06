import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../data/models/contract.dart';
import '../../../data/models/work_record.dart';
import '../widgets/success_bottom_sheet.dart';
import '../widgets/add_work_record_bottom_sheet.dart';
import '../widgets/work_record_card.dart';
import '../widgets/summary_item_container.dart';

@RoutePage()
class PayCycleSubmitHoursScreen extends StatefulWidget {
  final PayCycleContract contract;
  final WorkSubmission? initialSubmission;

  const PayCycleSubmitHoursScreen({
    Key? key,
    required this.contract,
    this.initialSubmission,
  }) : super(key: key);

  @override
  State<PayCycleSubmitHoursScreen> createState() =>
      _PayCycleSubmitHoursScreenState();
}

class _PayCycleSubmitHoursScreenState extends State<PayCycleSubmitHoursScreen> {
  DateTime selectedDate = DateTime.now();
  List<WorkRecord> workRecords = [];
  final TextEditingController workDescriptionController =
      TextEditingController();
  late TextEditingController dateController;
  String? attachmentName;

  @override
  void initState() {
    super.initState();
    if (widget.initialSubmission != null) {
      final sub = widget.initialSubmission!;
      selectedDate = sub.workDate;
      workRecords = List.from(sub.records ?? []);
      workDescriptionController.text = sub.description ?? '';
      attachmentName = sub.attachmentPath != null
          ? sub.attachmentPath!.split('/').last
          : null;
    }
    dateController = TextEditingController(
        text: DateFormat('d MMMM yyyy').format(selectedDate));
  }

  @override
  void dispose() {
    workDescriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('d MMMM yyyy').format(selectedDate);
      });
    }
  }

  void _addWorkRecord() async {
    final result = await showModalBottomSheet<WorkRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddWorkRecordBottomSheet(),
    );

    if (result != null) {
      setState(() {
        workRecords.add(result);
      });
    }
  }

  void _editWorkRecord(int index) async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddWorkRecordBottomSheet(
        workRecord: workRecords[index],
      ),
    );

    if (result == 'delete') {
      _deleteWorkRecord(index);
    } else if (result is WorkRecord) {
      setState(() {
        workRecords[index] = result;
      });
    }
  }

  void _deleteWorkRecord(int index) {
    setState(() {
      workRecords.removeAt(index);
    });
  }

  Duration _calculateTotalDuration() {
    return workRecords.fold(
      Duration.zero,
      (total, record) => total + record.duration,
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds <= 0) return '--';
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  void _submitHours() async {
    if (workRecords.isEmpty) {
      AppSnackbar.showError(context, 'Please add at least one record');
      return;
    }

    if (workDescriptionController.text.trim().isEmpty) {
      AppSnackbar.showError(context, 'Please add a work description');
      return;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => const SuccessBottomSheet(
        actionType: SuccessActionType.workSubmissionSubmitted,
      ),
    );

    context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = _calculateTotalDuration();
    final totalAmount = (totalDuration.inMinutes / 60) *
        double.tryParse(
            widget.contract.rate.replaceAll(RegExp(r'[^0-9.]'), ''))!;

    return Scaffold(
      backgroundColor: context.theme.colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: widget.initialSubmission != null
              ? 'Resubmit hours worked'
              : 'Submit hours',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.initialSubmission != null &&
                      widget.initialSubmission!.status ==
                          PaymentStatus.rejected &&
                      widget.initialSubmission!.rejectionReason != null) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.theme.colors.redDefault.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color:
                              context.theme.colors.redDefault.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for rejection',
                            style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.redDefault,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.initialSubmission!.rejectionReason!,
                            style: context.theme.fonts.textSmMedium.copyWith(
                              color: context.theme.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                  AppTextField(
                    controller: dateController,
                    readOnly: true,
                    labelText: 'Select date',
                    hintText: 'Select date',
                    onTap: _selectDate,
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(Assets.icons.calendar,
                          color: context.theme.colors.graySecondary),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Record items',
                          style: context.theme.fonts.textMdMedium),
                      GestureDetector(
                        onTap: _addWorkRecord,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: context.theme.colors.fillTertiary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text('Add record',
                              style: context.theme.fonts.textSmMedium),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  if (workRecords.isEmpty)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB0,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.theme.colors.strokeSecondary,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: context.theme.colors.textSecondary,
                            size: 20,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'You currently have no time record added.',
                              style: context.theme.fonts.textMdRegular.copyWith(
                                color: context.theme.colors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...workRecords.asMap().entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: WorkRecordCard(
                          record: entry.value,
                          onEdit: () => _editWorkRecord(entry.key),
                          onDelete: () => _deleteWorkRecord(entry.key),
                        ),
                      );
                    }).toList(),
                  SizedBox(height: 20.h),
                  AppTextField(
                    controller: workDescriptionController,
                    hintText: 'Work description',
                    maxLine: 7,
                  ),
                  SizedBox(height: 20.h),
                  Text('Attachment (Optional)',
                      style: context.theme.fonts.textMdMedium),
                  SizedBox(height: 8.h),
                  if (attachmentName == null)
                    PrimaryButton(
                      text: 'Click to upload',
                      onPressed: () =>
                          setState(() => attachmentName = 'Invoice.pdf'),
                      color: context.theme.colors.brandFill,
                      borderColor: context.theme.colors.brandStroke,
                      borderRadius: BorderRadius.circular(8.r),
                      textColor: context.theme.colors.brandDefaultContrast,
                      fixedSize: Size(double.infinity, 60.h),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB0,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: context.theme.colors.strokeSecondary),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.insert_drive_file_outlined,
                              color: context.theme.colors.textSecondary),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              attachmentName!,
                              style: context.theme.fonts.textMdMedium,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => attachmentName = null),
                            child: Icon(Icons.delete_outline,
                                color: context.theme.colors.redDefault),
                          ),
                        ],
                      ),
                    ),
                  if (attachmentName == null) ...[
                    SizedBox(height: 8.h),
                    Text.rich(
                      TextSpan(
                        style: context.theme.fonts.textSmRegular.copyWith(
                          color: context.theme.colors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Supported formats: '),
                          TextSpan(
                            text: 'JPG, PNG, HEIC or PDF. ',
                            style: context.theme.fonts.textSmMedium.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: 'Use '),
                          TextSpan(
                            text: '.ZIP',
                            style: context.theme.fonts.textSmMedium.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                          const TextSpan(text: ' to upload multiple files.'),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  SummaryItemContainer(
                    label: 'Total hours worked',
                    value: _formatDuration(totalDuration),
                  ),
                  SizedBox(height: 20.h),
                  SummaryItemContainer(
                    label: 'Hourly rate',
                    value: widget.contract.rate,
                  ),
                  SizedBox(height: 20.h),
                  SummaryItemContainer(
                    label: 'Calculated amount',
                    value: '${totalAmount.toInt()} USDT',
                    isBoldValue: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
            child: PrimaryButton(
              onPressed: _submitHours,
              text: widget.initialSubmission != null
                  ? 'Submit hours worked'
                  : 'Submit worked hours',
            ),
          ),
        ],
      ),
    );
  }
}
