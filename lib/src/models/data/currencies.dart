import 'currency_position.dart';
import 'from_json.dart';

class Currencies {
  final List<CurrencyPosition> currencies;

  Currencies(this.currencies);

  factory Currencies.fromJson(Map<String, dynamic> data) => Currencies(
        listFromJson(data, 'currencies', (d) => CurrencyPosition.fromJson(d)),
      );

  @override
  String toString() => 'Currencies(currencies: $currencies)';
}
