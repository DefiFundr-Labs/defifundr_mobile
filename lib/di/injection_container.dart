import 'package:get_it/get_it.dart';

import '../features/authentication/presentation/states/lets_get_to_know_you/lets_get_to_know_you_bloc.dart';

import 'package:defifundr_mobile/features/authentication/presentation/forgot_password/state/forgot_password_bloc.dart';

final sl = GetIt.I;

Future<void> registerServices() async {
  sl.registerLazySingleton<LetsGetToKnowYouBloc>(() => LetsGetToKnowYouBloc());
  sl.registerLazySingleton<ForgotPasswordBloc>(() => ForgotPasswordBloc());
}
