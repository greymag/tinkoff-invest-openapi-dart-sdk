import '../../../tinkoff_invest.dart';
import 'operation_type.dart';
import 'order_status.dart';

abstract class PlacedOrder {
  String get orderId;
  OperationType get operation;

  /// Статус заявки.
  OrderStatus get status;
  String? get rejectReason;

  /// Сообщение об ошибке.
  String? get message;

  int get requestedLots;
  int get executedLots;

  MoneyAmount? get commission;

  PlacedOrderType get orderType;
}

enum PlacedOrderType { limit, market }
