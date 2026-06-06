import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final TimeOffStatus status;

  const StatusChip({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusIconColor(context),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getStatusText(),
            style: context.theme.fonts.textSmMedium.copyWith(
              color: _getStatusIconColor(context),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case TimeOffStatus.pending:
        return context.theme.colors.orangeFill;
      case TimeOffStatus.approved:
        return context.theme.colors.greenFill;
      case TimeOffStatus.rejected:
        return context.theme.colors.redFill;
      case TimeOffStatus.used:
        return context.theme.colors.blueFill;
    }
  }

  Color _getStatusIconColor(BuildContext context) {
    switch (status) {
      case TimeOffStatus.pending:
        return context.theme.colors.orangeDefault;
      case TimeOffStatus.approved:
        return context.theme.colors.greenDefault;
      case TimeOffStatus.rejected:
        return context.theme.colors.redDefault;
      case TimeOffStatus.used:
        return context.theme.colors.blueDefault;
    }
  }

  String _getStatusText() {
    switch (status) {
      case TimeOffStatus.pending:
        return 'Pending approval';
      case TimeOffStatus.approved:
        return 'Approved';
      case TimeOffStatus.rejected:
        return 'Rejected';
      case TimeOffStatus.used:
        return 'Used';
    }
  }
}
