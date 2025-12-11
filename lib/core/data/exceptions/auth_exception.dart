class AuthException implements Exception {
  final String error;
  final String message;
  final int? statusCode;

  AuthException({required this.error, required this.message, this.statusCode});

  @override
  String toString() => "${runtimeType.toString()}: $error $message $statusCode";
}
