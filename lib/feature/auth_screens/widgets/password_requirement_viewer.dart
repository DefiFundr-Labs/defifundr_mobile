import 'package:flutter/material.dart';

class PasswordRequirementViewer extends StatelessWidget {
  final bool isPassed;
  final String text;
  const PasswordRequirementViewer({required this.isPassed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: isPassed ? Color(0xFFF0FDF4) : Color(0xFFFEF2F2),
        border: Border.all(color: isPassed ? Color(0x00bbf7d0) : Color(0xFFFECACA)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(isPassed ? Icons.check : Icons.close, size: 16, color: isPassed ? Color(0xFF16A34A) : Color(0xFFDC2626)),
          Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isPassed ? Color(0xFF16A34A) : Color(0xFFDC2626))),
        ],
      ),
    );
  }
}
