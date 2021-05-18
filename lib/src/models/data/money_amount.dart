import 'currency.dart';
import '../from_json.dart';

class MoneyAmount {
  final Currency currency;
  final double value;

  MoneyAmount(this.currency, this.value);

  factory MoneyAmount.fromJson(Map<String, dynamic> data) => MoneyAmount(
        currencyFromJson(data),
        data.requireDouble('value'),
      );

  @override
  String toString() => 'MoneyAmount(currency: $currency, value: $value)';
}
