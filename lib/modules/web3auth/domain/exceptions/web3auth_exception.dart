/// Exception class for Web3Auth errors
class Web3AuthException implements Exception {
  final String message;
  final String? code;

  Web3AuthException(this.message, [this.code]);

  @override
  String toString() => code != null
      ? 'Web3AuthException[$code]: $message'
      : 'Web3AuthException: $message';
}
