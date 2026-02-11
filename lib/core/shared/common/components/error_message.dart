import 'package:defifundr_mobile/core/utils/enum_file.dart';
import 'package:flutter/material.dart';
import '../overlay/overlay_message.dart';

class ErrorMessage extends StatelessWidget {
  final String title;
  final String message;

  const ErrorMessage({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return OverlayMessage(
      title: title,
      message: message,
      type: MessageType.error,
    );
  }
}
