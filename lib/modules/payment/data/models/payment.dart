// lib/feature/auth_screens/screens/upcoming_payments/models/payment.dart
import 'package:flutter/material.dart';

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
}
