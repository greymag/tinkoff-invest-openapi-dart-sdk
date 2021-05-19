const _defaultOrderTypeKey = 'type';

enum OrderType { limit, market }

class OrderTypeConverter {
  static const _data = {
    'Limit': OrderType.limit,
    'Market': OrderType.market,
  };

  const OrderTypeConverter();

  OrderType convert(String value) => _data[value]!;

  OrderType fromJson(Map<String, dynamic> data,
          [String key = _defaultOrderTypeKey]) =>
      convert(data[key] as String);

  String toJson(OrderType value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

OrderType orderTypeFromJson(Map<String, dynamic> data,
        [String key = _defaultOrderTypeKey]) =>
    const OrderTypeConverter().fromJson(data, key);

extension OrderTypeFromJsonExtension on Map<String, dynamic> {
  OrderType requireOrderType([String key = _defaultOrderTypeKey]) =>
      const OrderTypeConverter().fromJson(this, key);
}

extension OrderTypeExtension on OrderType {
  String get name => toString().split('.').last;

  String toJson() => const OrderTypeConverter().toJson(this);
}
