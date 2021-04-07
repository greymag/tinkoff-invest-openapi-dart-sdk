import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class MarketOrderResponse extends StdResponse<PlacedMarketOrder> {
  MarketOrderResponse(
      String trackingId, String status, PlacedMarketOrder payload)
      : super(trackingId, status, payload);

  factory MarketOrderResponse.fromJson(Map<String, dynamic> data) =>
      MarketOrderResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        PlacedMarketOrder.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'MarketOrderResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
