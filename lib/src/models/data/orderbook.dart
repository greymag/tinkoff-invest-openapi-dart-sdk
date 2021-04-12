import '../from_json.dart';

import 'order_response.dart';
import 'trade_status.dart';

class Orderbook {
  final String figi;
  final int depth;
  final List<OrderResponse> bids;
  final List<OrderResponse> asks;
  final TradeStatus tradeStatus;

  /// Шаг цены.
  final double minPriceIncrement;

  /// Номинал для облигаций.
  final double? faceValue;

  final double? lastPrice;
  final double? closePrice;

  /// Верхняя граница цены.
  final double? limitUp;

  /// Нижняя граница цены.
  final double? limitDown;

  Orderbook(
      this.figi,
      this.depth,
      this.bids,
      this.asks,
      this.tradeStatus,
      this.minPriceIncrement,
      this.faceValue,
      this.lastPrice,
      this.closePrice,
      this.limitUp,
      this.limitDown);

  factory Orderbook.fromJson(Map<String, dynamic> map) {
    return Orderbook(
      map['figi'] as String,
      map.requireInt('depth'),
      map.requireList('bids', (d) => OrderResponse.fromJson(d)),
      map.requireList('asks', (d) => OrderResponse.fromJson(d)),
      map.requireTradeStatus(),
      map.requireDouble('minPriceIncrement'),
      map.optionalDouble('faceValue'),
      map.optionalDouble('lastPrice'),
      map.optionalDouble('closePrice'),
      map.optionalDouble('limitUp'),
      map.optionalDouble('limitDown'),
    );
  }

  @override
  String toString() {
    return 'Orderbook(figi: $figi, depth: $depth, bids: $bids, '
        'asks: $asks, tradeStatus: $tradeStatus, '
        'minPriceIncrement: $minPriceIncrement, faceValue: $faceValue, '
        'lastPrice: $lastPrice, closePrice: $closePrice, limitUp: $limitUp, '
        'limitDown: $limitDown)';
  }
}
