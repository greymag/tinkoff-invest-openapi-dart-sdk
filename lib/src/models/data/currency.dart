import 'package:list_ext/list_ext.dart';

const _defaultCurrencyKey = 'currency';

// ignore: constant_identifier_names
enum Currency { RUB, USD, EUR, GBP, HKD, CHF, JPY, CNY, TRY }

class CurrencyConverter {
  static final _data =
      Currency.values.toMap((e) => e.toString().split('.').last, (e) => e);

  const CurrencyConverter();

  Currency convert(String value) => _data[value]!;

  Currency fromJson(Map<String, dynamic> data,
          [String key = _defaultCurrencyKey]) =>
      convert(data[key] as String);

  String toJson(Currency value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

Currency currencyFromJson(Map<String, dynamic> data,
        [String key = _defaultCurrencyKey]) =>
    const CurrencyConverter().fromJson(data, key);

extension CurrencyFromJsonExtension on Map<String, dynamic> {
  Currency requireCurrency([String key = _defaultCurrencyKey]) =>
      const CurrencyConverter().fromJson(this, key);
}

extension CurrencyExtension on Currency {
  String toJson() => const CurrencyConverter().toJson(this);
}
