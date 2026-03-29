
class WorkRecord {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String type;
  final Duration duration;

  WorkRecord({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.type,
    required this.duration,
  });

  WorkRecord copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    String? type,
    Duration? duration,
  }) {
    return WorkRecord(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      duration: duration ?? this.duration,
    );
  }
}
