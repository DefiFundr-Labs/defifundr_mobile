import 'package:defifundr_mobile/app.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/web3auth_service.dart';
import 'package:flutter/material.dart' show runApp;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() => _initializeImportantResources().then((_) => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Web3AuthService>(
            create: (context) => Web3AuthService(),
          ),
        ],
        child: const App(),
      ),
    ));

Future<void> _initializeImportantResources() async {
  await dotenv.load(fileName: ".env");
}
