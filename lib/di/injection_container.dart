import 'package:defifundr_mobile/screens/auth_screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:defifundr_mobile/screens/auth_screens/get_to_know_you_screen/bloc/lets_get_to_know_you_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> registerServices() async {
  sl.registerLazySingleton<LetsGetToKnowYouBloc>(() => LetsGetToKnowYouBloc());
  sl.registerLazySingleton<ForgotPasswordBloc>(() => ForgotPasswordBloc());
}
