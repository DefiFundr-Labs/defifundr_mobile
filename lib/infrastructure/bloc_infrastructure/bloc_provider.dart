import 'package:defifundr_mobile/feature/auth_screens/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get appProviders {
  return [
    BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(),
    ),
  ];
}
