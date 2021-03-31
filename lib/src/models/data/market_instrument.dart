import 'data.dart';
import 'from_json.dart';

class MarketInstrument {
  final String figi;
  final String ticker;
  final String? isin;

  /// Шаг цены.
  final double? minPriceIncrement;

  /// Номинал для облигаций.
  final double? faceValue;
  final int lot;

  /// Минимальное число инструментов для покупки должно быть не меньше,
  /// чем размер лота х количество лотов.
  final int? minQuantity;
  final Currency? currency;
  final String name;
  final InstrumentType type;

  MarketInstrument(
      this.figi,
      this.ticker,
      this.isin,
      this.minPriceIncrement,
      this.faceValue,
      this.lot,
      this.minQuantity,
      this.currency,
      this.name,
      this.type);

  @override
  String toString() {
    return 'MarketInstrument(figi: $figi, ticker: $ticker, isin: $isin, '
        'minPriceIncrement: $minPriceIncrement, faceValue: $faceValue, '
        'lot: $lot, minQuantity: $minQuantity, currency: $currency, '
        'name: $name, type: $type)';
  }

  factory MarketInstrument.fromJson(Map<String, dynamic> map) {
    return MarketInstrument(
      map['figi'] as String,
      map['ticker'] as String,
      map['isin'] as String?,
      map.optionalDouble('minPriceIncrement'),
      map.optionalDouble('faceValue'),
      map.requireInt('lot'),
      map.optionalInt('minQuantity'),
      map.optionalCurrency(),
      map['name'] as String,
      map.requireInstrumentType('type'),
    );
  }
}
