import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';

import 'status_chip.dart';

class TimeOffItem extends StatelessWidget {
  final TimeOffRequest timeOff;

  const TimeOffItem({
    Key? key,
    required this.timeOff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final timeOffDetail = _createTimeOffDetail();
        context.router.push(TimeOffDetailRoute(timeOffDetail: timeOffDetail));
      },
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeOff.dateRange,
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${timeOff.isPaid ? 'Paid' : 'Unpaid'} time off • ${timeOff.type}',
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${timeOff.days} day${timeOff.days > 1 ? 's' : ''}',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    color: context.theme.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                StatusChip(status: timeOff.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TimeOffDetail _createTimeOffDetail() {
    switch (timeOff.status) {
      case TimeOffStatus.pending:
        return TimeOffDetailFactory.createPendingRequest();
      case TimeOffStatus.rejected:
        return TimeOffDetailFactory.createRejectedRequest();
      case TimeOffStatus.approved:
        return TimeOffDetailFactory.createApprovedRequest();
      case TimeOffStatus.used:
        return TimeOffDetailFactory.createUsedRequest();
    }
  }
}
