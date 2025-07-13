class TimeTrackingSummary {
  final int totalHours;
  final int approvedHours;
  final int pendingHours;
  final int deniedHours;
  final DateTime startDate;
  final DateTime endDate;

  TimeTrackingSummary({
    required this.totalHours,
    required this.approvedHours,
    required this.pendingHours,
    required this.deniedHours,
    required this.startDate,
    required this.endDate,
  });
}