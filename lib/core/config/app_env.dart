enum Flavor { dev, staging, prod }

class AppEnv {
  const AppEnv._();

  static const String _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  static Flavor get flavor => switch (_flavor) {
        'staging' => Flavor.staging,
        'prod' => Flavor.prod,
        _ => Flavor.dev,
      };

  static bool get isDev => flavor == Flavor.dev;
  static bool get isStaging => flavor == Flavor.staging;
  static bool get isProd => flavor == Flavor.prod;

  static const String apiBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.dev.defifundr.com');

  static const String web3AuthClientId =
      String.fromEnvironment('WEB3AUTH_CLIENT_ID');
}
