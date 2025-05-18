import 'package:defifundr_mobile/feature/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_bloc.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/bloc/auth_event.dart';
import 'package:defifundr_mobile/infrastructure/web3auth/web3auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get appProviders {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        web3AuthService: context.read<Web3AuthService>(),
      )..add(const InitializeAuth()),
    ),
  ];
}
