import 'package:flutter_test/flutter_test.dart';

import 'patrol_base.dart';

/// Smoke tests for critical user flows
/// These tests should be run before every release
///
/// NOTE: Don't use group() with patrolTest - each test needs its own binding
void main() {
  // Smoke Tests
  patrol(
    'App launches successfully',
    tags: [TestTags.smoke],
    ($) async {
      await $.pumpApp();

      // App should display login screen on first launch
      await $.waitForText('Login');
      expect($('Login'), findsWidgets);
    },
  );

  patrol(
    'Login screen is fully functional',
    tags: [TestTags.smoke, TestTags.auth],
    ($) async {
      await $.pumpApp();
      await $.waitForText('Login');

      // Verify all login elements are present
      expect($('Email'), findsOneWidget);
      expect($('Password'), findsOneWidget);
      expect($('Login'), findsWidgets);
      expect($('Forgot Password'), findsOneWidget);
    },
  );

  patrol(
    'Navigation works correctly',
    tags: [TestTags.smoke],
    ($) async {
      await $.pumpApp();
      await $.waitForText('Login');

      // Test navigation to create account
      await $.tapButton('Create Account');
      await $.waitForText('Create Account');

      // Navigate back
      await $.native.pressBack();
      await $.waitForText('Login');
    },
  );

  // Critical Flows
  patrol(
    'User can complete forgot password flow entry',
    tags: [TestTags.smoke, TestTags.auth],
    ($) async {
      await $.pumpApp();
      await $.waitForText('Login');

      // Navigate to forgot password
      await $.tapButton('Forgot Password');
      await $.waitForText('Reset Password');

      // Enter email
      await $.enterTextField('Email', TestData.testEmail);

      // Verify submit button is available
      expect($('Submit'), findsOneWidget);
    },
  );
}
