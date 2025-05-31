import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class QuickPayment {
  final String id;
  final QuickPaymentsStatus status;
  final DateTime date;
  final BigInt amount;
  final String currency;
  final String description;
  final QuickPaymentsType paymentType;

  QuickPayment({
    required this.id,
    required this.status,
    required this.date,
    required this.amount,
    required this.currency,
    required this.description,
    required this.paymentType,
  });
  @override
  String toString() {
    return 'QuickPayment(id: $id, status: $status, date: $date, amount: $amount, currency: $currency, description: $description, paymentType: $paymentType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuickPayment &&
        other.id == id &&
        other.status == status &&
        other.date == date &&
        other.amount == amount &&
        other.currency == currency &&
        other.description == description &&
        other.paymentType == paymentType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        date.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        description.hashCode ^
        paymentType.hashCode;
  }
}

enum QuickPaymentsStatus { processing, successful, failed }

enum QuickPaymentsType { deposit, withdrawal, transfer }

extension QuickPaymentsStatusExtension on QuickPaymentsStatus {
  String get titleCase {
    final name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  Color get color {
    switch (this) {
      case QuickPaymentsStatus.processing:
        return AppColors.orangeDefault;
      case QuickPaymentsStatus.failed:
        return AppColors.redActive;
      case QuickPaymentsStatus.successful:
        return AppColors.greenActive;
    }
  }
}
