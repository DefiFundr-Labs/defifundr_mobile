import 'package:defifundr_mobile/core/cache/app_cache.dart';
import 'package:defifundr_mobile/core/network/network_provider.dart';
import 'package:defifundr_mobile/core/network_info/network_info.dart';
import 'package:defifundr_mobile/core/secure/secure.dart';
import 'package:defifundr_mobile/features/authentication/auth_service_locator.dart';
import 'package:defifundr_mobile/features/authentication/presentation/signup/states/let_get_started_bloc/lets_get_started_bloc.dart';
import 'package:defifundr_mobile/features/home/home_service_locator.dart';
import 'package:defifundr_mobile/features/profile/profile_service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.I;

Future<void> injector() async {
  await registerAuthDependencies();
  await registerHomeDependencies();
  await registerProfileDependencies();

  sl
    // Network
    ..registerLazySingleton<NetworkProvider>(NetworkProviderImpl.new)

    // Local Auth
    ..registerLazySingleton<SecureStorage>(
        () => ISecureStorage(FlutterSecureStorage()))

    // AppCache
    ..registerLazySingleton<AppCache>(() => AppCacheImpl())

    // Network Info
    ..registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()))

    // Register SignUpBloc
    ..registerFactory<LetsGetStartedBloc>(() => LetsGetStartedBloc());
}
