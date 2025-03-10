import 'package:defifundr_mobile/screens/auth_screens/get_to_know_you_screen/bloc/lets_get_to_know_you_bloc.dart';
import 'package:defifundr_mobile/screens/auth_screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

List<SingleChildWidget> get appProviders {
  return [
    BlocProvider<LetsGetToKnowYouBloc>(
        create: (context) => LetsGetToKnowYouBloc()),
    BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(),
    ),
  ];
}
