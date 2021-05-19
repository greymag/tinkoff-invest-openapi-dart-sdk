const _defaultBrokerAccountTypeKey = 'brokerAccountType';

enum BrokerAccountType {
  tinkoff,
  tinkoffIis,
}

extension BrokerAccountTypeExtension on BrokerAccountType {
  String get name => toString().split('.').last;
}

class BrokerAccountTypeConverter {
  static const _data = {
    'Tinkoff': BrokerAccountType.tinkoff,
    'TinkoffIis': BrokerAccountType.tinkoffIis,
  };

  const BrokerAccountTypeConverter();

  BrokerAccountType convert(String value) => _data[value]!;

  BrokerAccountType fromJson(Map<String, dynamic> data,
          [String key = _defaultBrokerAccountTypeKey]) =>
      convert(data[key] as String);
}

BrokerAccountType brokerAccountTypeFromJson(Map<String, dynamic> data,
        [String key = _defaultBrokerAccountTypeKey]) =>
    const BrokerAccountTypeConverter().fromJson(data, key);

extension BrokerAccountTypeFromJsonExtension on Map<String, dynamic> {
  BrokerAccountType requireBrokerAccountType(
          [String key = _defaultBrokerAccountTypeKey]) =>
      const BrokerAccountTypeConverter().fromJson(this, key);
}
