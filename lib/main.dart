import 'package:defifundr_mobile/app/app.dart';
import 'package:defifundr_mobile/modules/web3auth/data/service/web3auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<Web3AuthService>(
              create: (context) => Web3AuthService(),
            ),
          ],
          child: const App(),
        ),
      );
}

