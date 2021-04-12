import 'candle.dart';
import 'candle_resolution.dart';
import '../from_json.dart';

class Candles {
  final String figi;

  /// Интервал свечи.
  ///
  /// Интервал также определяет допустимый промежуток запроса.
  final CandleResolution interval;

  final List<Candle> candles;

  Candles(this.figi, this.interval, this.candles);

  factory Candles.fromJson(Map<String, dynamic> map) {
    return Candles(
      map['figi'] as String,
      map.requireCandleResolution('interval'),
      map.requireList('candles', (d) => Candle.fromJson(d)),
    );
  }

  @override
  String toString() =>
      'Candles(figi: $figi, interval: $interval, candles: $candles)';
}
