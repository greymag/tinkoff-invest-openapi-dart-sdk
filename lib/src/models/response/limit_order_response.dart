import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class LimitOrderResponse extends StdResponse<PlacedLimitOrder> {
  LimitOrderResponse(String trackingId, String status, PlacedLimitOrder payload)
      : super(trackingId, status, payload);

  factory LimitOrderResponse.fromJson(Map<String, dynamic> data) =>
      LimitOrderResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        PlacedLimitOrder.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'LimitOrderResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
