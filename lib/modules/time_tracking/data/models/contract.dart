import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';

enum ContractStatus { active, pending, pendingSignature, rejected }

extension ContractStatusExtension on ContractStatus {
  String get titleCase {
    switch (this) {
      case ContractStatus.active:
        return 'Active';
      case ContractStatus.pending:
        return 'Pending';
      case ContractStatus.pendingSignature:
        return 'Pending Signature';
      case ContractStatus.rejected:
        return 'Rejected';
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case ContractStatus.active:
        return context.theme.colors.greenDefault;
      case ContractStatus.pending:
      case ContractStatus.pendingSignature:
        return context.theme.colors.orangeDefault;
      case ContractStatus.rejected:
        return context.theme.colors.redDefault;
    }
  }

  Color fillColor(BuildContext context) {
    switch (this) {
      case ContractStatus.active:
        return context.theme.colors.greenFill;
      case ContractStatus.pending:
      case ContractStatus.pendingSignature:
        return context.theme.colors.orangeFill;
      case ContractStatus.rejected:
        return context.theme.colors.redFill;
    }
  }

  Color borderColor(BuildContext context) {
    switch (this) {
      case ContractStatus.active:
        return context.theme.colors.greenStroke;
      case ContractStatus.pending:
      case ContractStatus.pendingSignature:
        return context.theme.colors.orangeStroke;
      case ContractStatus.rejected:
        return context.theme.colors.redStroke;
    }
  }
}

enum ContractType { fixedRate, payAsYouGo, milestone }

extension ContractTypeExtension on ContractType {
  String get title {
    switch (this) {
      case ContractType.fixedRate:
        return 'Fixed rate';
      case ContractType.payAsYouGo:
        return 'Pay as you go';
      case ContractType.milestone:
        return 'Milestone';
    }
  }

  String get description {
    switch (this) {
      case ContractType.fixedRate:
        return 'Payment for work is at a fixed rate';
      case ContractType.payAsYouGo:
        return 'Payment for work is per hour/day etc';
      case ContractType.milestone:
        return 'Payment for work is in milestones';
    }
  }

  String get titleCase {
    switch (this) {
      case ContractType.fixedRate:
        return 'Fixed Rate';
      case ContractType.payAsYouGo:
        return 'Pay As You Go';
      case ContractType.milestone:
        return 'Milestone';
    }
  }
}

class TimeTrackingContract {
  final String id;
  final String title;
  final ContractType type;
  final double rate;
  final String currency;
  final ContractStatus status;

  TimeTrackingContract({
    required this.id,
    required this.title,
    required this.type,
    required this.rate,
    required this.currency,
    required this.status,
  });
}
