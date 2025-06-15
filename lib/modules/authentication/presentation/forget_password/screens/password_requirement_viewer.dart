import 'package:flutter/material.dart';

import '../../../../../core/design_system/theme_extension/app_theme_extension.dart';

class PasswordRequirementViewer extends StatelessWidget {
  final bool isPassed;
  final String text;
  const PasswordRequirementViewer({required this.isPassed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: isPassed ? Theme.of(context).colors.greenFill : Theme.of(context).colors.redFill,
        border: Border.all(color: isPassed ? Theme.of(context).colors.greenStroke : Theme.of(context).colors.redStroke),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(isPassed ? Icons.check : Icons.close, size: 16, color: isPassed ? Theme.of(context).colors.greenDefault : Theme.of(context).colors.redDefault),
          Text(
            text,
            style: Theme.of(context).fonts.textSmBold.copyWith(color: isPassed ? Theme.of(context).colors.greenDefault : Theme.of(context).colors.redDefault),
          ),
        ],
      ),
    );
  }
}
