// lib/feature/auth_screens/screens/upcoming_payments/models/payment.dart
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';

enum PaymentStatus {
  upcoming,
  overdue,
  pending,
  processing,
  successful,
  failed,
}

enum PaymentType {
  contract,
  invoice,
}

enum PaymentNetwork { ethereum, starknet, solana, stellar }

class Payment {
  final String title;
  final DateTime estimatedDate;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final PaymentType paymentType;
  final PaymentNetwork paymentNetwork;
  final String icon;
  final Color iconBackgroundColor;

  Payment({
    required this.title,
    required this.estimatedDate,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentType,
    required this.paymentNetwork,
    required this.icon,
    required this.iconBackgroundColor,
  });

  QuickPayment toQuickPayment() {
    QuickPaymentsStatus mapStatus() {
      switch (status) {
        case PaymentStatus.processing:
        case PaymentStatus.pending:
          return QuickPaymentsStatus.processing;
        case PaymentStatus.failed:
        case PaymentStatus.overdue:
          return QuickPaymentsStatus.failed;
        case PaymentStatus.successful:
        case PaymentStatus.upcoming:
          return QuickPaymentsStatus.successful;
      }
    }

    QuickPaymentsType mapType() {
      return amount < 0
          ? QuickPaymentsType.withdrawal
          : QuickPaymentsType.deposit;
    }

    return QuickPayment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      status: mapStatus(),
      date: estimatedDate,
      amount: BigInt.from(amount.abs()),
      currency: currency,
      description: title,
      paymentType: mapType(),
      network: paymentNetwork.name,
      imageUrl: icon,
      transactionHash: '0x1A2B3D4E5F6A7B8C9D0E1F2',
      from: amount > 0 ? '0xfEBA3E0dEca2Ad4CE...1970ae' : null,
      to: amount < 0 ? '0xfEBA3E0dEca2Ad4CE...1970ae' : null,
    );
  }
}
