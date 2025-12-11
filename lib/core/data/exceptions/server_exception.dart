class ServerException implements Exception {
  final String message;
  final String? error;
  final int? statusCode;

  ServerException({required this.message, this.error, this.statusCode});

  @override
  String toString() => "${runtimeType.toString()}: $message $error $statusCode";
}
