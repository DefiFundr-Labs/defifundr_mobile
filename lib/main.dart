import 'package:defifundr_mobile/app.dart';
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeImportantResources().then(
    (_) => runApp(
      const App(),
    ),
  );
}

Future<void> _initializeImportantResources() async {
  // Initialization
  await Web3AuthFlutter.init(
    Web3AuthOptions(
        // Get your client it from dashboard.web3auth.io
        clientId:
            'BLpGtbyE2L-GDOC56z2Byl5uSodCyTdq_2mn_AOckRDVb4ZqV94Jj5uyHMSymrigu2PMi-zozYe5t9z4iQRmNxQ',
        network: Network.sapphire_devnet,
        // Your redirect url, check how to configure.
        // Android: https://web3auth.io/docs/sdk/pnp/flutter/install#android-configuration
        // iOS: https://web3auth.io/docs/sdk/pnp/flutter/install#ios-configuration
        redirectUrl:
            Uri(scheme: 'com.defifundr.mobile', host: 'defifundr.com')),
  );

// // Call initialize() function to get privKey and user information without relogging in
// // user if a user has an active session. If no active session is present, the
// // function throws an error.
//   await Web3AuthFlutter.initialize();
}
