import 'package:flutter/material.dart';

class EnumCheckboxMeta<T> {
  final T value;
  final String label;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;

  EnumCheckboxMeta({
    required this.value,
    required this.label,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
  });
}
