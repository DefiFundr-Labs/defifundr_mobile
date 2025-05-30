import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/date_time_extension.dart';
import 'package:defifundr_mobile/feature/transaction/models/enums.dart';
import 'package:defifundr_mobile/feature/transaction/widgets/payment_tracker_status_widget.dart';
import 'package:flutter/material.dart';

class PaymentStatusWidget extends StatelessWidget {
  final PaymentStepStatus _status;
  final String _title;
  final String? _description1, _description2;
  final DateTime? _dueDate;
  final bool _isLastStep;
  const PaymentStatusWidget(
      {required PaymentStepStatus status,
      required String title,
      String? description1,
      String? description2,
      DateTime? dueDate,
      bool isLastStep = false,
      super.key})
      : _isLastStep = isLastStep,
        _description2 = description2,
        _dueDate = dueDate,
        _description1 = description1,
        _title = title,
        _status = status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            PaymentTrackerStatusWidget(_status),
            Flexible(
              child: RichText(
                text: TextSpan(
                    text: _title,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: _status == PaymentStepStatus.waiting ? context.theme.colors.textTertiary : null,
                    ),
                    children: [
                      if (_status != PaymentStepStatus.waiting) TextSpan(text: _dueDate?.toFormattedString2(), style: context.theme.fonts.textMdMedium),
                    ]),
              ),
            ),
          ],
        ),
        if (!_isLastStep)
          Row(
            spacing: 8,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                height: _description1 != null ? 44 : 20,
                width: 20,
                child: VerticalDivider(
                  color: _status == PaymentStepStatus.completed ? context.theme.colors.greenDefault : context.theme.colors.grayTertiary,
                  thickness: 1,
                  width: 1,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_description1 != null)
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: _description1,
                            style: context.theme.fonts.textMdRegular.copyWith(color: context.theme.colors.textSecondary),
                            children: [
                              if (_status != PaymentStepStatus.completed)
                                TextSpan(text: _dueDate?.toFormattedString2(), style: context.theme.fonts.textMdMedium),
                              TextSpan(
                                text: _description2,
                                style: context.theme.fonts.textMdRegular.copyWith(color: context.theme.colors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
