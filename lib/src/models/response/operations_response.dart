import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class OperationsResponse extends StdResponse<Operations> {
  OperationsResponse(String trackingId, String status, Operations payload)
      : super(trackingId, status, payload);

  factory OperationsResponse.fromJson(Map<String, dynamic> data) =>
      OperationsResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        Operations.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'OperationsResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
