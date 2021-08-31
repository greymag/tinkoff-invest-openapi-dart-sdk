import '../from_json.dart';

import 'money_amount.dart';
import 'operation_type.dart';
import 'order_status.dart';
import 'placed_order.dart';

class PlacedLimitOrder implements PlacedOrder {
  @override
  final String orderId;
  @override
  final OperationType operation;

  /// Статус заявки.
  @override
  final OrderStatus status;
  @override
  final String? rejectReason;

  /// Сообщение об ошибке.
  @override
  final String? message;

  @override
  final int requestedLots;
  @override
  final int executedLots;

  @override
  final MoneyAmount? commission;

  PlacedLimitOrder(this.orderId, this.operation, this.status, this.rejectReason,
      this.message, this.requestedLots, this.executedLots, this.commission);

  factory PlacedLimitOrder.fromJson(Map<String, dynamic> map) {
    return PlacedLimitOrder(
      map['orderId'] as String,
      map.requireOperationType(),
      map.requireOrderStatus(),
      map['rejectReason'] as String?,
      map['message'] as String?,
      map.requireInt('requestedLots'),
      map.requireInt('executedLots'),
      map.optional('commission', (d) => MoneyAmount.fromJson(d)),
    );
  }

  @override
  PlacedOrderType get orderType => PlacedOrderType.limit;

  @override
  String toString() {
    return 'PlacedLimitOrder(orderId: $orderId, operation: $operation, '
        'status: $status, rejectReason: $rejectReason, message: $message, '
        'requestedLots: $requestedLots, executedLots: $executedLots, '
        'commission: $commission)';
  }
}
