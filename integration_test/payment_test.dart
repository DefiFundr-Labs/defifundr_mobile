import 'package:flutter_test/flutter_test.dart';

import 'patrol_base.dart';

void main() {
  patrol(
    'User can navigate to finance screen',
    tags: [TestTags.smoke, TestTags.payment],
    ($) async {
      // This test assumes user is logged in
      // You would need to set up authentication first

      await $.pumpApp();

      // Navigate to finance (adjust based on your actual UI)
      await $.tapButton('Finance');

      // Verify finance screen is displayed
      await $.waitForText('Balance');
    },
  );

  patrol(
    'User can view wallet balance',
    tags: [TestTags.payment, TestTags.wallet],
    ($) async {
      await $.pumpApp();

      // Navigate to finance
      await $.tapButton('Finance');

      // Verify balance is displayed
      await $.waitForText('Balance');
      expect($('Balance'), findsOneWidget);
    },
  );

  patrol(
    'User can initiate withdrawal',
    tags: [TestTags.payment],
    ($) async {
      await $.pumpApp();

      // Navigate to finance
      await $.tapButton('Finance');
      await $.waitForText('Balance');

      // Tap withdraw button
      await $.tapButton('Withdraw');

      // Verify withdrawal screen
      await $.waitForText('Withdraw');
    },
  );

  patrol(
    'User can view transaction history',
    tags: [TestTags.payment],
    ($) async {
      await $.pumpApp();

      // Navigate to finance
      await $.tapButton('Finance');

      // Navigate to transactions
      await $.tapButton('Transactions');

      // Verify transaction list is shown
      await $.waitForText('Transaction');
    },
  );

  patrol(
    'User can receive payment via QR code',
    tags: [TestTags.payment],
    ($) async {
      await $.pumpApp();

      // Navigate to receive
      await $.tapButton('Receive');

      // Verify QR code screen is shown
      await $.waitForText('Scan');
    },
  );
}
