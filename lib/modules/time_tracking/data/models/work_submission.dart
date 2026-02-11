import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';

class WorkSubmission {
  final DateTime selectedDate;
  final List<TimeRecord> timeRecords;
  final String workDescription;
  final String? attachmentName;
  final double hourlyRate;
  final String currency;

  WorkSubmission({
    required this.selectedDate,
    required this.timeRecords,
    required this.workDescription,
    this.attachmentName,
    required this.hourlyRate,
    required this.currency,
  });

  Duration get totalDuration {
    return timeRecords.fold(
      Duration.zero,
      (total, record) => total + record.duration,
    );
  }

  double get calculatedAmount {
    double totalHours = totalDuration.inMinutes / 60.0;
    return totalHours * hourlyRate;
  }

  String get formattedTotalHours {
    int hours = totalDuration.inHours;
    int minutes = totalDuration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}
