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
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getStatusIconColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _getStatusText(),
            style: TextStyle(
              color: _getStatusIconColor(),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case TimeOffStatus.pending:
        return Colors.orange.shade50;
      case TimeOffStatus.approved:
        return Colors.green.shade50;
      case TimeOffStatus.rejected:
        return Colors.red.shade50;
      case TimeOffStatus.used:
        return Colors.blue.shade50;
    }
  }

  Color _getStatusIconColor() {
    switch (status) {
      case TimeOffStatus.pending:
        return Colors.orange;
      case TimeOffStatus.approved:
        return Colors.green;
      case TimeOffStatus.rejected:
        return Colors.red;
      case TimeOffStatus.used:
        return Colors.blue;
    }
  }

  String _getStatusText() {
    switch (status) {
      case TimeOffStatus.pending:
        return 'Pending ap...';
      case TimeOffStatus.approved:
        return 'Approved';
      case TimeOffStatus.rejected:
        return 'Rejected';
      case TimeOffStatus.used:
        return 'Used';
    }
  }
}
