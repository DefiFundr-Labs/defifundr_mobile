import 'package:flutter_test/flutter_test.dart';

import 'patrol_base.dart';

void main() {
  patrol(
    'User can view login screen',
    tags: [TestTags.smoke, TestTags.auth],
    ($) async {
      // Arrange - Start the app
      await $.pumpApp();

      // Assert - Verify login screen is displayed
      await $.waitForText('Login');
    },
  );

  patrol(
    'User can enter email and password',
    tags: [TestTags.auth],
    ($) async {
      // Arrange
      await $.pumpApp();
      await $.waitForText('Login');

      // Act - Enter credentials
      await $.enterTextField('Email', TestData.testEmail);
      await $.enterTextField('Password', TestData.testPassword);

      // Assert - Fields contain entered text
      expect($('Email').text, contains(TestData.testEmail));
    },
  );

  patrol(
    'User sees validation error for invalid email',
    tags: [TestTags.auth],
    ($) async {
      // Arrange
      await $.pumpApp();
      await $.waitForText('Login');

      // Act - Enter invalid email
      await $.enterTextField('Email', 'invalid-email');
      await $.tapButton('Login');

      // Assert - Validation error shown
      await $.waitForText('valid email');
    },
  );

  patrol(
    'User can navigate to forgot password',
    tags: [TestTags.auth],
    ($) async {
      // Arrange
      await $.pumpApp();
      await $.waitForText('Login');

      // Act - Tap forgot password
      await $.tapButton('Forgot Password');

      // Assert - Reset password screen shown
      await $.waitForText('Reset Password');
    },
  );

  patrol(
    'User can navigate to create account',
    tags: [TestTags.auth],
    ($) async {
      // Arrange
      await $.pumpApp();
      await $.waitForText('Login');

      // Act - Tap create account
      await $.tapButton('Create Account');

      // Assert - Create account screen shown
      await $.waitForText('Create Account');
    },
  );
}
