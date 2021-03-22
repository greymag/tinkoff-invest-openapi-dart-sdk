import 'package:list_ext/list_ext.dart';

// ignore: constant_identifier_names
enum Currency { RUB, USD, EUR, GBP, HKD, CHF, JPY, CNY, TRY }

class CurrencyConverter {
  static final _data =
      Currency.values.toMap((e) => e.toString().split('.').last, (e) => e);

  const CurrencyConverter();

  Currency convert(String value) => _data[value]!;
}
