class NetworkException implements Exception {
  final int? statusCode;
  final String message;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() => "${runtimeType.toString()}($statusCode): $message";
}
