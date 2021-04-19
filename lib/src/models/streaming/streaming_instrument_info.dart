import 'package:tinkoff_invest/src/models/streaming/streaming_trade_status.dart';

import '../from_json.dart';

/// Структура с информацией по инструменту.
class StreamingInstrumentInfo {
  /// FIGI.
  final String figi;

  /// Статус торгов.
  final StreamingTradeStatus tradeStatus;

  /// Шаг цены.
  final double minPriceIncrement;

  /// Лот.
  final double lot;

  /// НКД.
  ///
  /// Возвращается только для бондов
  final double? accruedInterest;

  /// Верхняя граница заявки.
  ///
  /// Возвращается только для RTS инструментов
  final double? limitUp;

  /// Нижняя граница заявки.
  ///
  /// Возвращается только для RTS инструментов
  final double? limitDown;

  StreamingInstrumentInfo(this.figi, this.tradeStatus, this.minPriceIncrement,
      this.lot, this.accruedInterest, this.limitUp, this.limitDown);

  factory StreamingInstrumentInfo.fromJson(Map<String, dynamic> map) {
    return StreamingInstrumentInfo(
      map['figi'] as String,
      map.requireTradeStatus(),
      map.requireDouble('min_price_increment'),
      map.requireDouble('lot'),
      map.optionalDouble('accrued_interest'),
      map.optionalDouble('limit_up'),
      map.optionalDouble('limit_down'),
    );
  }

  @override
  String toString() {
    return 'StreamingInstrumentInfo(figi: $figi, tradeStatus: $tradeStatus, '
        'minPriceIncrement: $minPriceIncrement, lot: $lot, '
        'accruedInterest: $accruedInterest, limitUp: $limitUp, '
        'limitDown: $limitDown)';
  }
}
