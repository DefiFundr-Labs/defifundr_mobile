import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final TimeOffStatus status;
  final bool isPill;

  const StatusChip({
    Key? key,
    required this.status,
    this.isPill = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPill) {
      final color = _getStatusIconColor(context);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Text(
          _getStatusText(forPill: true),
          style: context.theme.fonts.textXsSemiBold.copyWith(
            color: color,
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getStatusIconColor(context),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            ellipsify(word: _getStatusText(), maxLength: 8),
            style: context.theme.fonts.textSmMedium.copyWith(
              color: _getStatusIconColor(context),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getStatusIconColor(BuildContext context) {
    switch (status) {
      case TimeOffStatus.pending:
        return context.theme.colors.orangeActive;
      case TimeOffStatus.approved:
        return context.theme.colors.greenActive;
      case TimeOffStatus.rejected:
        return context.theme.colors.redActive;
      case TimeOffStatus.used:
        return context.theme.colors.blueActive;
    }
  }

  String _getStatusText({bool forPill = false}) {
    switch (status) {
      case TimeOffStatus.pending:
        return forPill ? 'Pending' : 'Pending approval';
      case TimeOffStatus.approved:
        return 'Approved';
      case TimeOffStatus.rejected:
        return 'Rejected';
      case TimeOffStatus.used:
        return 'Used';
    }
  }
}
