class TimeRecord {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String type; // 'Regular hours', 'Break', 'Overtime'
  final Duration duration;

  TimeRecord({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.duration,
  });

  TimeRecord copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    String? type,
    Duration? duration,
  }) {
    return TimeRecord(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      duration: duration ?? this.duration,
    );
  }
}