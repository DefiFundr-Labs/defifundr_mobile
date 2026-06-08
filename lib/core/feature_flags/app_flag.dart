/// A type-safe definition of a feature flag.
///
/// Define all flags as constants in [AppFlags] — never use raw strings.
/// dart-define keys use a `FLAG_` prefix matching the flag key.
///
/// ```dart
/// static const newPayrollFlow = AppFlag<bool>('new_payroll_flow', defaultValue: false);
/// ```
class AppFlag<T> {
  const AppFlag(this.key, {required this.defaultValue});

  /// The key used in remote config and local cache.
  final String key;

  /// dart-define key: `FLAG_<key>`.
  String get dartDefineKey => 'FLAG_$key';

  /// Value returned when the flag is absent or fails to parse.
  final T defaultValue;

  @override
  String toString() => 'AppFlag<$T>($key)';
}
