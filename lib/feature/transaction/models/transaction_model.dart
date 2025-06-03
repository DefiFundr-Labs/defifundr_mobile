import 'package:equatable/equatable.dart';

enum TransactionType {
  withdrawal,
  contract,
  invoice,
  quickpay,
}

enum TransactionStatus {
  processing,
  successful,
  failed,
}

class TimelineStep {
  final String title;
  final DateTime time;
  final bool completed;

  const TimelineStep({
    required this.title,
    required this.time,
    this.completed = false,
  });
}

class TransactionModel extends Equatable {
  final TransactionType type;
  final String title;
  final String amount;
  final String currency;
  final DateTime timestamp;
  final TransactionStatus status;

  // Common fields
  final String? network;
  final String? fromAddress;
  final String? transactionId;
  final DateTime? date;

  // Contract specific fields
  final String? contractName;
  final String? contractType;
  final String? invoiceNumber;
  final String? client;

  // Invoice specific fields
  final String? billedTo;
  final String? invoiceId;

  // Withdrawal specific fields
  final String? withdrawalAddress;
  final String? withdrawalMethod;

  // Quickpay specific fields
  final String? recipient;
  final String? paymentMethod;

  // Timeline for contract and invoice
  final List<TimelineStep>? timeline;

  const TransactionModel({
    required this.type,
    required this.title,
    required this.amount,
    required this.currency,
    required this.timestamp,
    required this.status,
    this.network,
    this.fromAddress,
    this.transactionId,
    this.date,
    this.contractName,
    this.contractType,
    this.invoiceNumber,
    this.client,
    this.billedTo,
    this.invoiceId,
    this.withdrawalAddress,
    this.withdrawalMethod,
    this.recipient,
    this.paymentMethod,
    this.timeline,
  });

  @override
  List<Object?> get props => [
        type,
        title,
        amount,
        currency,
        timestamp,
        status,
        network,
        fromAddress,
        transactionId,
        date,
        contractName,
        contractType,
        invoiceNumber,
        client,
        billedTo,
        invoiceId,
        withdrawalAddress,
        withdrawalMethod,
        recipient,
        paymentMethod,
        timeline,
      ];
}
