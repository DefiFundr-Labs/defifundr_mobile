import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:flutter/material.dart';
import '../../data/models/time_off.dart';
import '../widgets/status_chip.dart';
import '../widgets/success_bottom_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';

@RoutePage()
class CancelTimeOffRequestScreen extends StatefulWidget {
  final TimeOffDetail timeOffDetail;

  const CancelTimeOffRequestScreen({
    Key? key,
    required this.timeOffDetail,
  }) : super(key: key);

  @override
  State<CancelTimeOffRequestScreen> createState() =>
      _CancelTimeOffRequestScreenState();
}

class _CancelTimeOffRequestScreenState
    extends State<CancelTimeOffRequestScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.timeOffDetail.status == TimeOffStatus.pending) {
      _reasonController.text =
          'Decided to cancel the holiday plans due to a change in family circumstances.';
    }
  }

  void _submitCancellation() {
    if (_reasonController.text.trim().isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => SuccessBottomSheet(
          title: 'Cancellation submitted',
          subtitle: 'Your cancellation request has been submitted\nfor review.',
          // icon: Icon(Icons.cancel_outlined,
          //     size: 32, color: context.theme.colors.redDefault),
        ),
      );
    } else {
      AppSnackbar.showError(
          context, 'Please provide a reason for cancellation');
    }
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
          title: 'Cancel time off request',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.timeOffDetail.status ==
                      TimeOffStatus.approved) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.theme.colors.orangeFill,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: context.theme.colors.orangeStroke),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Approval needed',
                            style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.orangeDefault,
                            ),
                          ),
                          Text(
                            'The cancellation of this time off will require approval.',
                            style: context.theme.fonts.textSmRegular.copyWith(
                              color: context.theme.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.theme.colors.bgB1,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.timeOffDetail.reason,
                                style: context.theme.fonts.textBaseSemiBold
                                    .copyWith(
                                  color: context.theme.colors.textPrimary,
                                ),
                              ),
                            ),
                            StatusChip(
                                status: widget.timeOffDetail.status,
                                isPill: true),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.timeOffDetail.dateRange} • ${widget.timeOffDetail.totalDays} days holiday',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.timeOffDetail.description,
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        if (widget.timeOffDetail.attachmentFileName !=
                            null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: context.theme.colors.bgB1,
                                borderRadius: BorderRadius.circular(32),
                                border: BoxBorder.all(
                                    color: context.theme.colors.strokePrimary)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.description_outlined,
                                    size: 16,
                                    color: context.theme.colors.textTertiary),
                                const SizedBox(width: 4),
                                Text(
                                  widget.timeOffDetail.attachmentFileName!,
                                  style:
                                      context.theme.fonts.textSmMedium.copyWith(
                                    color: context.theme.colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Reason for cancellation',
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _reasonController,
                    maxLine: 5,
                    hintText: 'Enter reason...',
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: PrimaryButton(
              onPressed: _submitCancellation,
              text: 'Submit cancellation',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}
