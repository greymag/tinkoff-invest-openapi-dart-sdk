const _defaultOperationTypeKey = 'operation';

enum OperationType { buy, sell }

class OperationTypeConverter {
  static const _data = {
    'Buy': OperationType.buy,
    'Sell': OperationType.sell,
  };

  const OperationTypeConverter();

  OperationType convert(String value) => _data[value]!;

  OperationType fromJson(Map<String, dynamic> data,
          [String key = _defaultOperationTypeKey]) =>
      convert(data[key] as String);

  String toJson(OperationType value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

OperationType operationTypeFromJson(Map<String, dynamic> data,
        [String key = _defaultOperationTypeKey]) =>
    const OperationTypeConverter().fromJson(data, key);

extension OperationTypeFromJsonExtension on Map<String, dynamic> {
  OperationType requireOperationType([String key = _defaultOperationTypeKey]) =>
      const OperationTypeConverter().fromJson(this, key);
}

extension OperationTypeExtension on OperationType {
  String toJson() => const OperationTypeConverter().toJson(this);
}
