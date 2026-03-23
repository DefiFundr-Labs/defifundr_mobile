import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';

import '../../../data/models/work_record.dart';

class AddWorkRecordBottomSheet extends StatefulWidget {
  final WorkRecord? workRecord;
  final bool isDeliverable;
  final bool isDay;

  const AddWorkRecordBottomSheet({
    Key? key,
    this.workRecord,
    this.isDeliverable = false,
    this.isDay = false,
  }) : super(key: key);

  @override
  _AddWorkRecordBottomSheetState createState() =>
      _AddWorkRecordBottomSheetState();
}

class _AddWorkRecordBottomSheetState extends State<AddWorkRecordBottomSheet> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedType;
  DateTime? selectedDate;
  late TextEditingController typeController;
  late TextEditingController dateController;

  final List<String> hourRecordTypes = [
    'Regular hours',
    'Break',
    'Overtime',
  ];

  final List<String> dayRecordTypes = [
    'Full day',
    'Half day',
  ];

  List<String> get recordTypes =>
      widget.isDay ? dayRecordTypes : hourRecordTypes;

  @override
  void initState() {
    super.initState();
    if (widget.workRecord != null) {
      final record = widget.workRecord!;
      startTime = TimeOfDay.fromDateTime(record.startTime);
      endTime = TimeOfDay.fromDateTime(record.endTime);
      selectedDate = record.startTime;
      selectedType = record.type;
      typeController = TextEditingController(text: selectedType);
      dateController = TextEditingController(
          text: selectedDate != null
              ? DateFormat('d MMMM yyyy').format(selectedDate!)
              : '');
    } else {
      startTime = null;
      endTime = null;
      selectedDate = DateTime.now();
      selectedType = null;
      typeController = TextEditingController();
      dateController = TextEditingController(
          text: DateFormat('d MMMM yyyy').format(selectedDate!));
    }
  }

  @override
  void dispose() {
    typeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('d MMMM yyyy').format(selectedDate!);
      });
    }
  }

  void _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  Duration _calculateDuration() {
    if (startTime == null || endTime == null) return Duration.zero;
    final now = DateTime.now();
    final start = DateTime(
        now.year, now.month, now.day, startTime!.hour, startTime!.minute);
    final end =
        DateTime(now.year, now.month, now.day, endTime!.hour, endTime!.minute);

    return end.difference(start);
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds <= 0) return '--';
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '--:--';
    return time.format(context);
  }

  void _saveRecord() {
    if (!widget.isDeliverable &&
        !widget.isDay &&
        (startTime == null || endTime == null || selectedType == null)) {
      AppSnackbar.showError(
          context, 'Please select record type, start and end times');
      return;
    }

    if (widget.isDay && (selectedDate == null || selectedType == null)) {
      AppSnackbar.showError(context, 'Please select date and record type');
      return;
    }

    if (widget.isDeliverable &&
        (selectedType == null || selectedType!.trim().isEmpty)) {
      AppSnackbar.showError(context, 'Please enter deliverable title');
      return;
    }

    final duration = (widget.isDeliverable || widget.isDay)
        ? Duration.zero
        : _calculateDuration();

    if (!widget.isDeliverable && !widget.isDay && duration.isNegative) {
      AppSnackbar.showError(context, 'End time must be after start time');
      return;
    }

    final now = DateTime.now();
    final workRecord = WorkRecord(
      id: widget.workRecord?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: (widget.isDeliverable || widget.isDay)
          ? (selectedDate ?? now)
          : DateTime(
              now.year, now.month, now.day, startTime!.hour, startTime!.minute),
      endTime: (widget.isDeliverable || widget.isDay)
          ? (selectedDate ?? now)
          : DateTime(
              now.year, now.month, now.day, endTime!.hour, endTime!.minute),
      type: selectedType!,
      duration: duration,
    );

    context.router.maybePop(workRecord);
  }

  void _deleteRecord() {
    context.router.maybePop('delete');
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.workRecord != null;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 12, 20, 32.h + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: context.theme.colors.grayTertiary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
                isEdit
                    ? (widget.isDeliverable
                        ? 'Edit deliverable'
                        : (widget.isDay
                            ? 'Edit day worked'
                            : 'Edit hours worked'))
                    : (widget.isDeliverable
                        ? 'Add deliverable'
                        : (widget.isDay
                            ? 'Record day worked'
                            : 'Record hours worked')),
                style: context.theme.fonts.heading3Bold),
            SizedBox(height: 24.h),
            if (widget.isDay) ...[
              AppTextField(
                controller: dateController,
                readOnly: true,
                labelText: 'Date',
                hintText: 'Select date',
                onTap: _selectDate,
                suffixType: SuffixType.customIcon,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.calendar_today,
                      color: context.theme.colors.graySecondary, size: 20),
                ),
              ),
              SizedBox(height: 16.h),
            ],
            Stack(
              children: [
                AppTextField(
                  labelText: null,
                  controller: typeController,
                  readOnly: !widget.isDeliverable,
                  hintText: widget.isDeliverable
                      ? 'Deliverable title'
                      : (widget.isDay ? 'Select type' : 'Record type'),
                  suffixType: widget.isDeliverable
                      ? SuffixType.none
                      : SuffixType.customIcon,
                  suffixIcon: widget.isDeliverable
                      ? null
                      : Icon(Icons.keyboard_arrow_down,
                          color: context.theme.colors.textSecondary),
                  onChanged: (value) {
                    if (widget.isDeliverable) {
                      selectedType = value;
                    }
                  },
                ),
                if (!widget.isDeliverable)
                  Positioned.fill(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 0,
                        dropdownColor: context.theme.colors.bgB0,
                        items: recordTypes
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type,
                                      style: context.theme.fonts.textMdMedium),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedType = value;
                              typeController.text = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
            if (!widget.isDeliverable && !widget.isDay) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildTimeSelector(
                        context, 'Start time', startTime, _selectStartTime),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildTimeSelector(
                        context, 'End time', endTime, _selectEndTime),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB1,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No of hours',
                        style: context.theme.fonts.textMdRegular.copyWith(
                            color: context.theme.colors.textSecondary)),
                    Text(
                        startTime != null && endTime != null
                            ? _formatDuration(_calculateDuration())
                            : '--',
                        style: context.theme.fonts.textMdMedium),
                  ],
                ),
              ),
            ],
            SizedBox(height: 24.h),
            if (isEdit)
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPressed: _deleteRecord,
                      text: 'Delete',
                      color: Colors.transparent,
                      borderColor: context.theme.colors.redDefault,
                      textColor: context.theme.colors.redDefault,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: _saveRecord,
                      text: 'Save changes',
                    ),
                  ),
                ],
              )
            else
              PrimaryButton(
                onPressed: _saveRecord,
                text: widget.isDeliverable
                    ? 'Add deliverable'
                    : (widget.isDay ? 'Add day' : 'Add record'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
      BuildContext context, String label, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB0,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.theme.colors.strokeSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: context.theme.fonts.textSmRegular
                    .copyWith(color: context.theme.colors.textSecondary)),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatTime(time),
                    style: context.theme.fonts.textMdMedium),
                Icon(Icons.access_time,
                    color: context.theme.colors.textSecondary, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
