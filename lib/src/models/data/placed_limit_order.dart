import 'from_json.dart';

import 'money_amount.dart';
import 'operation_type.dart';
import 'order_status.dart';

class PlacedLimitOrder {
  final String orderId;
  final OperationType operation;

  /// Статус заявки.
  final OrderStatus status;
  final String? rejectReason;

  /// Сообщение об ошибке.
  final String? message;

  final int requestedLots;
  final int executedLots;

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
  String toString() {
    return 'PlacedLimitOrder(orderId: $orderId, operation: $operation, '
        'status: $status, rejectReason: $rejectReason, message: $message, '
        'requestedLots: $requestedLots, executedLots: $executedLots, '
        'commission: $commission)';
  }
}
