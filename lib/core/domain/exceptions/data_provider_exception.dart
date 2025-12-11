class DataProviderException implements Exception {
  final String message;
  final int? statusCode;

  DataProviderException({required this.message, this.statusCode});

  @override
  String toString() => "$runtimeType: $message, $statusCode";
}
