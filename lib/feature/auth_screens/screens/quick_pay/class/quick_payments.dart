import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class QuickPayment {
  final String id;
  final QuickPaymentsStatus status;
  final DateTime date;
  final BigInt amount;
  final String currency;
  final String description;
  final String network;
  final String imageUrl;
  final String transactionHash;
  final String? from;
  final String? to;
  final QuickPaymentsType paymentType;

  QuickPayment({
    required this.id,
    required this.status,
    required this.date,
    required this.amount,
    required this.currency,
    required this.description,
    required this.paymentType,
    required this.network,
    required this.imageUrl,
    required this.transactionHash,
    this.from,
    this.to,
  }) : assert(
          from != null || to != null,
          'Either "from" or "to" must be non-null',
        );
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

  Color fillColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (this) {
      case QuickPaymentsStatus.processing:
        return isDark ? AppColorDark.orangeFill : AppColors.orangeFill;
      case QuickPaymentsStatus.failed:
        return isDark ? AppColorDark.redFill : AppColors.redFill;
      case QuickPaymentsStatus.successful:
        return isDark ? AppColorDark.greenFill : AppColors.greenFill;
    }
  }

  Color borderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (this) {
      case QuickPaymentsStatus.processing:
        return isDark ? AppColorDark.orangeStroke : AppColors.orangeStroke;
      case QuickPaymentsStatus.failed:
        return isDark ? AppColorDark.redStroke : AppColors.redStroke;
      case QuickPaymentsStatus.successful:
        return isDark ? AppColorDark.greenStroke : AppColors.greenStroke;
    }
  }

  Color textColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (this) {
      case QuickPaymentsStatus.processing:
        return isDark ? AppColorDark.orangeDefault : AppColors.orangeDefault;
      case QuickPaymentsStatus.failed:
        return isDark ? AppColorDark.redActive : AppColors.redActive;
      case QuickPaymentsStatus.successful:
        return isDark ? AppColorDark.greenActive : AppColors.greenActive;
    }
  }
}
