import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class FilterTransactions extends TransactionEvent {
  final List<String> types;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String search;

  const FilterTransactions({
    required this.types,
    required this.status,
    this.startDate,
    this.endDate,
    this.search = '',
  });

  @override
  List<Object> get props => [
        types,
        status,
        startDate ?? '',
        endDate ?? '',
        search,
      ];
}
