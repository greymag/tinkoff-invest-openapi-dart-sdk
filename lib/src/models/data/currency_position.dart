import 'currency.dart';
import '../from_json.dart';

class CurrencyPosition {
  final Currency currency;
  final double balance;
  final double? blocked;

  CurrencyPosition(this.currency, this.balance, this.blocked);

  factory CurrencyPosition.fromJson(Map<String, dynamic> data) {
    return CurrencyPosition(
      currencyFromJson(data),
      doubleFromJson(data, 'balance'),
      doubleOrNullFromJson(data, 'blocked'),
    );
  }

  @override
  String toString() =>
      'CurrencyPosition(currency: $currency, balance: $balance, blocked: $blocked)';
}
