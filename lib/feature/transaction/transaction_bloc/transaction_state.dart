import 'package:defifundr_mobile/feature/transaction/models/transaction_model.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final Map<DateTime, List<TransactionModel>> transactionsByDate;

  const TransactionLoaded(this.transactionsByDate);

  @override
  List<Object> get props => [transactionsByDate];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}
