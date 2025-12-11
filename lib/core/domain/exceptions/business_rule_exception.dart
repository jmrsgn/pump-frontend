class BusinessRuleException implements Exception {
  final String message;

  const BusinessRuleException(this.message);

  @override
  String toString() => "$runtimeType: $message";
}
