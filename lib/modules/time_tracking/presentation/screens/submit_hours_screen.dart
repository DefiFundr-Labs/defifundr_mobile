import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/coin_assets.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/work_submission.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/attachment_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/date_selector.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/submission_summary.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/time_record_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/widgets/work_description_field.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/success_bottom_sheet.dart';
import '../widgets/add_time_record_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SubmitHoursScreen extends StatefulWidget {
  final TimeTrackingContract contract;

  const SubmitHoursScreen({Key? key, required this.contract}) : super(key: key);

  @override
  _SubmitHoursScreenState createState() => _SubmitHoursScreenState();
}

class _SubmitHoursScreenState extends State<SubmitHoursScreen> {
  DateTime selectedDate = DateTime(2025, 1, 12);
  List<TimeRecord> timeRecords = [];
  TextEditingController workDescriptionController = TextEditingController();
  late TextEditingController dateController;
  String? attachmentName;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(
        text: DateFormat('MMM d, yyyy').format(selectedDate));
  }

  @override
  void dispose() {
    workDescriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _addTimeRecord() async {
    final result = await showModalBottomSheet<TimeRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTimeRecordBottomSheet(),
    );

    if (result != null) {
      setState(() {
        timeRecords.add(result);
      });
    }
  }

  void _editTimeRecord(int index) async {
    final result = await showModalBottomSheet<TimeRecord>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTimeRecordBottomSheet(
        timeRecord: timeRecords[index],
      ),
    );

    if (result != null) {
      setState(() {
        timeRecords[index] = result;
      });
    }
  }

  void _deleteTimeRecord(int index) {
    setState(() {
      timeRecords.removeAt(index);
    });
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('MMM d, yyyy').format(selectedDate);
      });
    }
  }

  void _uploadAttachment() {
    setState(() {
      attachmentName = 'File name';
    });
  }

  void _removeAttachment() {
    setState(() {
      attachmentName = null;
    });
  }

  void _submitHours() async {
    if (timeRecords.isEmpty) {
      AppSnackbar.showError(context, 'Please add at least one time record');
      return;
    }

    if (workDescriptionController.text.trim().isEmpty) {
      AppSnackbar.showError(context, 'Please add a work description');
      return;
    }

    final submission = WorkSubmission(
      selectedDate: selectedDate,
      timeRecords: timeRecords,
      workDescription: workDescriptionController.text,
      attachmentName: attachmentName,
      hourlyRate: widget.contract.rate,
      currency: widget.contract.currency,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => SuccessBottomSheet(),
    );

    context.router.maybePop(submission);
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
          title: 'Submit hours',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: dateController,
                    readOnly: true,
                    labelText: 'Select Date',
                    hintText: 'Select Date',
                    onTap: _selectDate,
                    suffixType: SuffixType.customIcon,
                    suffixIcon: SvgPicture.asset(Assets.icons.calendar,
                        color: context.theme.colors.graySecondary),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Record items',
                          style: context.theme.fonts.textMdMedium),
                      GestureDetector(
                        onTap: _addTimeRecord,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: context.theme.colors.fillTertiary,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text('Add record',
                              style: context.theme.fonts.textSmMedium),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  if (timeRecords.isEmpty)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB1,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: context.theme.colors.strokeSecondary,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey[600],
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
                    ...timeRecords.asMap().entries.map((entry) {
                      int index = entry.key;
                      TimeRecord record = entry.value;
                      return TimeRecordCard(
                        timeRecord: record,
                        onEdit: () => _editTimeRecord(index),
                        onDelete: () => _deleteTimeRecord(index),
                      );
                    }).toList(),
                  SizedBox(height: 20),
                  AppTextField(
                    controller: workDescriptionController,
                    hintText: 'Work description',
                    maxLine: 6,
                  ),
                  SizedBox(height: 20.0),
                  AttachmentSection(
                    attachmentName: attachmentName,
                    onUpload: _uploadAttachment,
                    onRemove: _removeAttachment,
                  ),
                  SizedBox(height: 20.0),
                  SubmissionSummary(
                    totalHours: timeRecords.isNotEmpty
                        ? timeRecords.fold(
                            Duration.zero,
                            (total, record) => total + record.duration,
                          )
                        : Duration.zero,
                    hourlyRate: widget.contract.rate,
                    currency: widget.contract.currency,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: PrimaryButton(
              onPressed: _submitHours,
              enableShine: false,
              text: 'Submit worked hours',
            ),
          ),
        ],
      ),
    );
  }
}
