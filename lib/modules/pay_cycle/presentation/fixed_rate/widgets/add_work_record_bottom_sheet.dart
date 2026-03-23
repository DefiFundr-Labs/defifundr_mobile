import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';

import '../../../data/models/work_record.dart';

class AddWorkRecordBottomSheet extends StatefulWidget {
  final WorkRecord? workRecord;

  const AddWorkRecordBottomSheet({Key? key, this.workRecord}) : super(key: key);

  @override
  _AddWorkRecordBottomSheetState createState() =>
      _AddWorkRecordBottomSheetState();
}

class _AddWorkRecordBottomSheetState extends State<AddWorkRecordBottomSheet> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedType;
  late TextEditingController typeController;

  final List<String> recordTypes = [
    'Regular hours',
    'Break',
    'Overtime',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.workRecord != null) {
      final record = widget.workRecord!;
      startTime = TimeOfDay.fromDateTime(record.startTime);
      endTime = TimeOfDay.fromDateTime(record.endTime);
      selectedType = record.type;
      typeController = TextEditingController(text: selectedType);
    } else {
      startTime = null;
      endTime = null;
      selectedType = null;
      typeController = TextEditingController();
    }
  }

  @override
  void dispose() {
    typeController.dispose();
    super.dispose();
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
    final start = DateTime(now.year, now.month, now.day, startTime!.hour, startTime!.minute);
    final end = DateTime(now.year, now.month, now.day, endTime!.hour, endTime!.minute);

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
    if (startTime == null || endTime == null || selectedType == null) {
      AppSnackbar.showError(
          context, 'Please select record type, start and end times');
      return;
    }

    final duration = _calculateDuration();

    if (duration.isNegative) {
      AppSnackbar.showError(context, 'End time must be after start time');
      return;
    }

    final now = DateTime.now();
    final workRecord = WorkRecord(
      id: widget.workRecord?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime(
          now.year, now.month, now.day, startTime!.hour, startTime!.minute),
      endTime: DateTime(
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
        padding: EdgeInsets.fromLTRB(20, 12, 20, 32.h + MediaQuery.of(context).viewInsets.bottom),
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
            Text(isEdit ? 'Edit hours worked' : 'Record hours worked',
                style: context.theme.fonts.heading3Bold),
            SizedBox(height: 24.h),
            Stack(
              children: [
                AppTextField(
                  labelText: null,
                  controller: typeController,
                  readOnly: true,
                  hintText: 'Record type',
                  suffixType: SuffixType.customIcon,
                  suffixIcon: Icon(Icons.keyboard_arrow_down,
                      color: context.theme.colors.textSecondary),
                ),
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
                text: 'Add record',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(BuildContext context, String label, TimeOfDay? time, VoidCallback onTap) {
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
            Text(label, style: context.theme.fonts.textSmRegular.copyWith(color: context.theme.colors.textSecondary)),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatTime(time), style: context.theme.fonts.textMdMedium),
                Icon(Icons.access_time, color: context.theme.colors.textSecondary, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
