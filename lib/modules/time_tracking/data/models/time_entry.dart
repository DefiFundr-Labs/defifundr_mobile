class TimeEntry {
  final String id;
  final String contractId;
  final DateTime startTime;
  final DateTime endTime;
  final double amount;
  final String currency;
  final String status;
  final Duration duration;

  TimeEntry({
    required this.id,
    required this.contractId,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.currency,
    required this.status,
    required this.duration,
  });
}