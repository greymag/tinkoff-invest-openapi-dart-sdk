const _defaultOrderStatusKey = 'status';

enum OrderStatus {
  newOrder,
  partiallyFill,
  fill,
  cancelled,
  replaced,
  rendingCancel,
  rejected,
  pendingReplace,
  pendingNew
}

class OrderStatusConverter {
  static const _data = {
    'New': OrderStatus.newOrder,
    'PartiallyFill': OrderStatus.partiallyFill,
    'Fill': OrderStatus.fill,
    'Cancelled': OrderStatus.cancelled,
    'Replaced': OrderStatus.replaced,
    'PendingCancel': OrderStatus.rendingCancel,
    'Rejected': OrderStatus.rejected,
    'PendingReplace': OrderStatus.pendingReplace,
    'PendingNew': OrderStatus.pendingNew,
  };

  const OrderStatusConverter();

  OrderStatus convert(String value) => _data[value]!;

  OrderStatus fromJson(Map<String, dynamic> data,
          [String key = _defaultOrderStatusKey]) =>
      convert(data[key] as String);

  String toJson(OrderStatus value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

OrderStatus orderStatusFromJson(Map<String, dynamic> data,
        [String key = _defaultOrderStatusKey]) =>
    const OrderStatusConverter().fromJson(data, key);

extension OrderStatusFromJsonExtension on Map<String, dynamic> {
  OrderStatus requireOrderStatus([String key = _defaultOrderStatusKey]) =>
      const OrderStatusConverter().fromJson(this, key);
}

extension OrderStatusExtension on OrderStatus {
  String get name => toString().split('.').last;

  String toJson() => const OrderStatusConverter().toJson(this);
}
