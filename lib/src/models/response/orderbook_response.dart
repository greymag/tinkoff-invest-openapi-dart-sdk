import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class OrderbookResponse extends StdResponse<Orderbook> {
  OrderbookResponse(String trackingId, String status, Orderbook payload)
      : super(trackingId, status, payload);

  factory OrderbookResponse.fromJson(Map<String, dynamic> data) =>
      OrderbookResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        Orderbook.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'OrderbookResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
