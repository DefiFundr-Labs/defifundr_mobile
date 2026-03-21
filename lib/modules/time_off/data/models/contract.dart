import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';

class TimeOffContract {
  final String id;
  final String title;
  final ContractType type;
  final String paymentAmount;
  final String paymentFrequency;
  final bool isActive;

  TimeOffContract({
    required this.id,
    required this.title,
    required this.type,
    required this.paymentAmount,
    required this.paymentFrequency,
    required this.isActive,
  });
}
