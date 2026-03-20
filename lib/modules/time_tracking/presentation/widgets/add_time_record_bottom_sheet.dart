import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';

class AddTimeRecordBottomSheet extends StatefulWidget {
  final TimeRecord? timeRecord;

  const AddTimeRecordBottomSheet({Key? key, this.timeRecord}) : super(key: key);

  @override
  _AddTimeRecordBottomSheetState createState() =>
      _AddTimeRecordBottomSheetState();
}

class _AddTimeRecordBottomSheetState extends State<AddTimeRecordBottomSheet> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String selectedType = 'Regular hours';
  late TextEditingController typeController;

  final List<String> recordTypes = [
    'Regular hours',
    'Break',
    'Overtime',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.timeRecord != null) {
      final record = widget.timeRecord!;
      startTime = TimeOfDay.fromDateTime(record.startTime);
      endTime = TimeOfDay.fromDateTime(record.endTime);
      selectedType = record.type;
    }
    typeController = TextEditingController(text: selectedType);
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
    final DateTime now = DateTime.now();
    final DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      startTime!.hour,
      startTime!.minute,
    );
    final DateTime end = DateTime(
      now.year,
      now.month,
      now.day,
      endTime!.hour,
      endTime!.minute,
    );

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
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _saveRecord() {
    if (startTime == null || endTime == null) {
      AppSnackbar.showError(context, 'Please select both start and end times');
      return;
    }

    final duration = _calculateDuration();

    if (duration.isNegative) {
      AppSnackbar.showError(context, 'End time must be after start time');
      return;
    }

    final now = DateTime.now();
    final timeRecord = TimeRecord(
      id: widget.timeRecord?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime(
        now.year,
        now.month,
        now.day,
        startTime!.hour,
        startTime!.minute,
      ),
      endTime: DateTime(
        now.year,
        now.month,
        now.day,
        endTime!.hour,
        endTime!.minute,
      ),
      type: selectedType,
      duration: duration,
    );

    context.router.maybePop(timeRecord);
  }

  void _deleteRecord() {
    context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.timeRecord != null;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.0),
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: context.theme.colors.grayTertiary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(height: 12),
            Text(isEdit ? 'Edit hours worked' : 'Record hours worked',
                style: context.theme.fonts.heading3Bold),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AppTextField(
                        labelText: 'Record type',
                        controller: typeController,
                        readOnly: true,
                        hintText: 'Record type',
                        suffixType: SuffixType.customIcon,
                        suffixIcon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey[600]),
                      ),
                      Positioned.fill(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedType,
                            isExpanded: true,
                            iconSize: 0,
                            dropdownColor: context.theme.colors.bgB1,
                            items: recordTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style:
                                      context.theme.fonts.textMdMedium.copyWith(
                                    color: context.theme.colors.textPrimary,
                                  ),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (BuildContext context) {
                              return recordTypes.map((String type) {
                                return const SizedBox.shrink();
                              }).toList();
                            },
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedType = newValue;
                                  typeController.text = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.0),

                  // Time Selection - FIXED
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectStartTime,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: context.theme.colors.bgB1,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: context.theme.colors.strokeSecondary,
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Start time',
                                      style: context.theme.fonts.textSmRegular
                                          .copyWith(
                                              color: context
                                                  .theme.colors.textSecondary),
                                    ),
                                    Text(_formatTime(startTime),
                                        style:
                                            context.theme.fonts.textMdRegular),
                                  ],
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  Assets.icons.clock,
                                  color: context.theme.colors.graySecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectEndTime,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: context.theme.colors.bgB1,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: context.theme.colors.strokeSecondary,
                              ),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'End time',
                                      style: context.theme.fonts.textSmRegular
                                          .copyWith(
                                              color: context
                                                  .theme.colors.textSecondary),
                                    ),
                                    Text(_formatTime(endTime),
                                        style:
                                            context.theme.fonts.textMdRegular),
                                  ],
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  Assets.icons.clock,
                                  color: context.theme.colors.graySecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: context.theme.colors.fillTertiary,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No of hours',
                          style: context.theme.fonts.textMdRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        Text(_formatDuration(_calculateDuration()),
                            style: context.theme.fonts.textMdMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  if (isEdit)
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: PrimaryButton(
                            color: Colors.transparent,
                            borderColor: context.theme.colors.redDefault,
                            textColor: context.theme.colors.redDefault,
                            text: 'Delete',
                            enableShine: false,
                            onPressed: _deleteRecord,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: PrimaryButton(
                            text: 'Save changes',
                            enableShine: false,
                            onPressed: _saveRecord,
                          ),
                        ),
                      ],
                    )
                  else
                    PrimaryButton(
                      onPressed: _saveRecord,
                      enableShine: false,
                      text: 'Add record',
                    ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
