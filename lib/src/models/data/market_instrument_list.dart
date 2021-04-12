import 'market_instrument.dart';
import '../from_json.dart';

class MarketInstrumentList {
  final int total;
  final List<MarketInstrument> instruments;

  MarketInstrumentList(this.total, this.instruments);

  @override
  String toString() =>
      'MarketInstrumentList(total: $total, ' 'instruments: $instruments)';

  factory MarketInstrumentList.fromJson(Map<String, dynamic> map) {
    return MarketInstrumentList(
      map.requireInt('total'),
      map.requireList('instruments', (d) => MarketInstrument.fromJson(d)),
    );
  }
}
