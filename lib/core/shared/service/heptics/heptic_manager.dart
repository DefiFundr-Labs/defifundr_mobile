import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticManager {
  static void lightImpact() {
    HapticFeedback.lightImpact();
    debugPrint('Light Impact Haptic Triggered');
  }

  static void mediumImpact() {
    HapticFeedback.mediumImpact();
    debugPrint('Medium Impact Haptic Triggered');
  }

  static void heavyImpact() {
    HapticFeedback.heavyImpact();
    debugPrint('Heavy Impact Haptic Triggered');
  }

  static void selectionClick() {
    HapticFeedback.selectionClick();
    debugPrint('Selection Click Haptic Triggered');
  }

  static void vibrate() {
    HapticFeedback.vibrate();
    debugPrint('Vibration Triggered');
  }

  // Trigger custom feedback with callback
  void customFeedback(Function feedbackType) {
    feedbackType();
  }
}
