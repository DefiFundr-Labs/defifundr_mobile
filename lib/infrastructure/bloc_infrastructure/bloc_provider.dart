import 'package:defifundr_mobile/feature/auth_screens/auth_bloc/auth_bloc.dart'
    as feature_auth;
import 'package:defifundr_mobile/feature/transaction_screen/transaction_bloc/transaction_bloc.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_bloc.dart'
    as web3auth_bloc;
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_event.dart'
    as web3auth_bloc;

import 'package:defifundr_mobile/infrastructure/web3auth/web3auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get appProviders {
  return [
    BlocProvider<feature_auth.AuthBloc>(
      create: (context) => feature_auth.AuthBloc(),
    ),
    BlocProvider<web3auth_bloc.AuthBloc>(
      create: (context) => web3auth_bloc.AuthBloc(

        web3AuthService: context.read<Web3AuthService>(),
      )..add(const web3auth_bloc.InitializeAuth()),
    ),
    BlocProvider<TransactionBloc>(
      create: (context) => TransactionBloc(),
    ),
  ];
}
