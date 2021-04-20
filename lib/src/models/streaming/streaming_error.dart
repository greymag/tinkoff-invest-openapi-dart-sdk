/// Структура с информацией об ошибке.
class StreamingError {
  /// Сообщение об ошибке.
  final String error;

  /// ID запроса, если передан при запросе.
  final String? requestId;

  StreamingError(this.error, this.requestId);

  factory StreamingError.fromJson(Map<String, dynamic> map) {
    return StreamingError(
      map['error'] as String,
      map['request_id'] as String?,
    );
  }

  @override
  String toString() => 'StreamingError(error: $error, requestId: $requestId)';
}
