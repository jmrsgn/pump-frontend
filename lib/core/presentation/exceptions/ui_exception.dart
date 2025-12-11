class UiException implements Exception {
  final String message;

  UiException(this.message);

  @override
  String toString() => "${runtimeType.toString()}: $message";
}
