import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/data/from_json.dart';

import 'response.dart';

class OrdersResponse extends StdResponse<List<Order>> {
  OrdersResponse(String trackingId, String status, List<Order> payload)
      : super(trackingId, status, payload);

  factory OrdersResponse.fromJson(Map<String, dynamic> data) => OrdersResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        data.requireList('payload', (d) => Order.fromJson(d)),
      );

  @override
  String toString() => 'OrdersResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
