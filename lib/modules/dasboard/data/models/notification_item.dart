import 'package:flutter/material.dart';

enum NotificationType {
  invoice,
  contract,
  contractPayment,
  quickpay,
  timeOff,
  general,
}

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final NotificationType type;
  final bool isRead;
  final String? actionLabel;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.type,
    this.isRead = false,
    this.actionLabel,
  });

  Color get iconBackgroundColor {
    switch (type) {
      case NotificationType.invoice:
        return const Color(0xFFED8936);
      case NotificationType.contract:
        return const Color(0xFF805AD5);
      case NotificationType.contractPayment:
        return const Color(0xFF38A169);
      case NotificationType.quickpay:
        return const Color(0xFFE53E3E);
      case NotificationType.timeOff:
        return const Color(0xFF3182CE);
      case NotificationType.general:
        return const Color(0xFF718096);
    }
  }

  IconData get iconData {
    switch (type) {
      case NotificationType.invoice:
        return Icons.receipt_long_rounded;
      case NotificationType.contract:
        return Icons.description_rounded;
      case NotificationType.contractPayment:
        return Icons.payments_rounded;
      case NotificationType.quickpay:
        return Icons.flash_on_rounded;
      case NotificationType.timeOff:
        return Icons.beach_access_rounded;
      case NotificationType.general:
        return Icons.notifications_rounded;
    }
  }
}
