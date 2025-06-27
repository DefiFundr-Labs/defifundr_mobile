import 'package:defifundr_mobile/app/app.dart';
import 'package:defifundr_mobile/modules/web3auth/data/service/web3auth_service.dart';
import 'package:flutter/material.dart' show runApp;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// main.dart - Remove SystemChrome.setSystemUIOverlayStyle
void main() async {
  await _initializeImportantResources().then((_) => runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<Web3AuthService>(
              create: (context) => Web3AuthService(),
            ),
          ],
          child: const App(),
        ),
      ));
}

Future<void> _initializeImportantResources() async {
  // await dotenv.load(fileName: ".env");
}
