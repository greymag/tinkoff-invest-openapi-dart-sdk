import 'response.dart';

class EmptyResponse extends StdResponse<void> {
  EmptyResponse(String trackingId, String status)
      : super(trackingId, status, null);

  factory EmptyResponse.fromJson(Map<String, dynamic> data) => EmptyResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
      );

  @override
  String toString() => 'EmptyResponse(trackingId: $trackingId, '
      'status: $status)';
}
