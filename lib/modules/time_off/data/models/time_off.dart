enum TimeOffStatus { pending, approved, rejected, used }

class TimeOffRequest {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final int days;
  final String type;
  final TimeOffStatus status;
  final bool isPaid;

  TimeOffRequest({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.type,
    required this.status,
    required this.isPaid,
  });

  String get dateRange {
    final start = '${startDate.day} ${_getMonthName(startDate.month)}';
    final end =
        '${endDate.day} ${_getMonthName(endDate.month)} ${endDate.year}';
    return '$start - $end';
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }
}
