import 'package:flutter/material.dart';

class OnboardingStep {
  final String title;
  final String iconAsset; // Path to SVG asset
  final bool isDone;
  final VoidCallback? onTap;

  OnboardingStep({
    required this.title,
    required this.iconAsset,
    this.isDone = false,
    this.onTap,
  });
}
