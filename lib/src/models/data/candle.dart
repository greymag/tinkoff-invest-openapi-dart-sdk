import 'from_json.dart';
import 'candle_resolution.dart';

/// Структура свечи.
class Candle {
  /// FIGI.
  final String figi;

  /// Интервал свечи.
  ///
  /// Интервал также определяет допустимый промежуток запроса.
  final CandleResolution interval;

  /// Цена открытия.
  final double o;

  /// Цена закрытия.
  final double c;

  /// Наибольшая цена.
  final double h;

  /// Наименьшая цена.
  final double l;

  /// Объем торгов.
  final int v;

  /// Время.
  final DateTime time;

  Candle(this.figi, this.interval, this.o, this.c, this.h, this.l, this.v,
      this.time);

  factory Candle.fromJson(Map<String, dynamic> map) {
    return Candle(
      map['figi'] as String,
      map.requireCandleResolution('interval'),
      map.requireDouble('o'),
      map.requireDouble('c'),
      map.requireDouble('h'),
      map.requireDouble('l'),
      map.requireInt('v'),
      map.requireDateTime('time'),
    );
  }

  @override
  String toString() {
    return 'Candle(figi: $figi, interval: $interval, o: $o, c: $c, h: $h, '
        'l: $l, v: $v, time: $time)';
  }
}
