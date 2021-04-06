import 'from_json.dart';

import 'operation_type.dart';
import 'order_status.dart';
import 'order_type.dart';

class Order {
  final String orderId;
  final String figi;
  final OperationType operation;

  /// Статус заявки.
  final OrderStatus status;

  final int requestedLots;
  final int executedLots;

  /// Тип заявки.
  final OrderType type;

  final double price;

  Order(this.orderId, this.figi, this.operation, this.status,
      this.requestedLots, this.executedLots, this.type, this.price);

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      map['orderId'] as String,
      map['figi'] as String,
      map.requireOperationType(),
      map.requireOrderStatus(),
      map.requireInt('requestedLots'),
      map.requireInt('executedLots'),
      map.requireOrderType(),
      map.requireDouble('price'),
    );
  }

  @override
  String toString() {
    return 'Order(orderId: $orderId, figi: $figi, operation: $operation, '
        'status: $status, requestedLots: $requestedLots, '
        'executedLots: $executedLots, type: $type, price: $price)';
  }
}
