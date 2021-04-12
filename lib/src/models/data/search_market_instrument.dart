import '../from_json.dart';

import 'currency.dart';
import 'instrument_type.dart';

class SearchMarketInstrument {
  final String figi;
  final String ticker;
  final String? isin;

  /// Шаг цены
  final double? minPriceIncrement;

  final int lot;
  final Currency? currency;
  final String name;
  final InstrumentType type;

  SearchMarketInstrument(this.figi, this.ticker, this.isin,
      this.minPriceIncrement, this.lot, this.currency, this.name, this.type);

  factory SearchMarketInstrument.fromJson(Map<String, dynamic> map) {
    return SearchMarketInstrument(
      map['figi'] as String,
      map['ticker'] as String,
      map['isin'] as String?,
      map.optionalDouble('minPriceIncrement'),
      map.requireInt('lot'),
      map.optionalCurrency(),
      map['name'] as String,
      map.requireInstrumentType('type'),
    );
  }

  @override
  String toString() {
    return 'SearchMarketInstrument(figi: $figi, ticker: $ticker, isin: $isin, '
        'minPriceIncrement: $minPriceIncrement, lot: $lot, currency: $currency, '
        'name: $name, type: $type)';
  }
}
