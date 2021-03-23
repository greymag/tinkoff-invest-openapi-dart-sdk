import 'response.dart';

class ErrorResponse extends StdResponse<ErrorData> {
  ErrorResponse(String trackingId, String status, ErrorData payload)
      : super(trackingId, status, payload);

  factory ErrorResponse.fromJson(Map<String, dynamic> data) => ErrorResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Error',
        ErrorData.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'PortfolioResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}

class ErrorData {
  final String code;
  final String message;

  ErrorData(this.code, this.message);

  factory ErrorData.fromJson(Map<String, dynamic> data) {
    return ErrorData(
      data['code'] as String,
      data['message'] as String,
    );
  }

  @override
  String toString() => 'ErrorData(code: $code, message: $message)';
}
