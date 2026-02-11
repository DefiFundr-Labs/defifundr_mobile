import 'package:defifundr_mobile/app/app.dart';
import 'package:defifundr_mobile/modules/web3auth/data/service/web3auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Patrol test configuration for DefiFundr
///
/// This file contains the base configuration for all Patrol tests.
/// Import this in your test files to use the configured [patrolTest].

/// Native automator configuration
final nativeConfig = NativeAutomatorConfig(
  // Android configuration
  packageName: 'com.defifundr.mobile',
  bundleId: 'com.defifundr.mobile',
  // Timeouts
  findTimeout: const Duration(seconds: 10),
  connectionTimeout: const Duration(seconds: 60),
);

/// Configure Patrol with app-specific settings
void patrol(
  String description,
  Future<void> Function(PatrolIntegrationTester $) callback, {
  bool? skip,
  List<String>? tags,
  NativeAutomatorConfig? nativeAutomatorConfig,
}) {
  patrolTest(
    description,
    callback,
    skip: skip,
    tags: tags,
    nativeAutomatorConfig: nativeAutomatorConfig ?? nativeConfig,
  );
}

/// Creates the app widget for testing
Widget createTestApp() {
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider<Web3AuthService>(
        create: (context) => Web3AuthService(),
      ),
    ],
    child: const App(),
  );
}

/// Extension to add app-specific helpers to PatrolIntegrationTester
extension PatrolAppHelpers on PatrolIntegrationTester {
  /// Pumps the DefiFundr app and waits for it to settle
  Future<void> pumpApp() async {
    await pumpWidgetAndSettle(createTestApp());
  }

  /// Waits for a widget with the given text to be visible
  Future<PatrolFinder> waitForText(String text, {Duration? timeout}) async {
    final finder = call(text);
    await finder.waitUntilVisible(timeout: timeout);
    return finder;
  }

  /// Waits for a widget with the given key to be visible
  Future<PatrolFinder> waitForKey(String key, {Duration? timeout}) async {
    final finder = call(Key(key));
    await finder.waitUntilVisible(timeout: timeout);
    return finder;
  }

  /// Taps a button and waits for the UI to settle
  Future<void> tapButton(String text) async {
    await call(text).tap();
    await pumpAndSettle();
  }

  /// Enters text into a field identified by its hint text
  Future<void> enterTextField(String hint, String text) async {
    await call(hint).enterText(text);
  }

  /// Scrolls down until a widget with the given text is visible
  Future<void> scrollToText(String text) async {
    await call(text).scrollTo();
  }

  /// Handles biometric authentication prompts (Face ID / Fingerprint)
  Future<void> handleBiometricPrompt({bool authenticate = true}) async {
    if (authenticate) {
      // Accept biometric authentication
      try {
        await native.tap(Selector(textContains: 'Use'));
      } catch (_) {
        // Biometric prompt might not appear in all cases
      }
    } else {
      // Dismiss biometric authentication
      try {
        await native.tap(Selector(textContains: 'Cancel'));
      } catch (_) {
        // Biometric prompt might not appear in all cases
      }
    }
  }

  /// Grants location permission when prompted
  Future<void> grantLocationPermission() async {
    await native.grantPermissionWhenInUse();
  }

  /// Grants camera permission when prompted
  Future<void> grantCameraPermission() async {
    await native.grantPermissionWhenInUse();
  }

  /// Grants notification permission when prompted
  Future<void> grantNotificationPermission() async {
    await native.grantPermissionWhenInUse();
  }

  /// Dismisses any system dialog (like permission dialogs)
  Future<void> dismissSystemDialog() async {
    try {
      await native.tap(Selector(textContains: 'Allow'));
    } catch (_) {
      try {
        await native.tap(Selector(textContains: 'OK'));
      } catch (_) {
        // No dialog to dismiss
      }
    }
  }
}

/// Common test data used across integration tests
class TestData {
  // Test user credentials
  static const testEmail = 'test@defifundr.com';
  static const testPassword = 'Test@123456';
  static const testPin = '123456';

  // Test wallet data
  static const testWalletAddress = '0x1234567890abcdef1234567890abcdef12345678';

  // Test transaction data
  static const testAmount = '100.00';
  static const testRecipient = 'recipient@defifundr.com';
}

/// Tags for categorizing tests
class TestTags {
  static const smoke = 'smoke';
  static const regression = 'regression';
  static const auth = 'auth';
  static const payment = 'payment';
  static const wallet = 'wallet';
  static const kyc = 'kyc';
}
