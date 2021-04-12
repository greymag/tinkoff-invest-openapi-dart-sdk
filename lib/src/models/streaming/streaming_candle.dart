import '../from_json.dart';
import 'streaming_candle_interval.dart';

/// Структура свечи.
class StreamingCandle {
  /// FIGI.
  final String figi;

  /// Интервал свечи.
  ///
  /// Интервал также определяет допустимый промежуток запроса.
  final StreamingCandleInterval interval;

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

  StreamingCandle(this.figi, this.interval, this.o, this.c, this.h, this.l,
      this.v, this.time);

  factory StreamingCandle.fromJson(Map<String, dynamic> map) {
    return StreamingCandle(
      map['figi'] as String,
      map.requireCandleInterval('interval'),
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
    return 'StreamingCandle(figi: $figi, interval: $interval, o: $o, c: $c, '
        'h: $h, l: $l, v: $v, time: $time)';
  }
}
