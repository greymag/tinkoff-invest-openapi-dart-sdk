import '../from_json.dart';

/// Структура со стаканом.
class StreamingOrderbook {
  /// FIGI.
  final String figi;

  /// Глубина стакана.
  final int depth;

  /// Массив предложений цены.
  final List<StreamingOrderbookItem> bids;

  /// Массив запросов цены.
  final List<StreamingOrderbookItem> asks;

  StreamingOrderbook(this.figi, this.depth, this.bids, this.asks);

  factory StreamingOrderbook.fromJson(Map<String, dynamic> map) {
    return StreamingOrderbook(
      map['figi'] as String,
      map.requireInt('depth'),
      map.requirePriceRequests('bids'),
      map.requirePriceRequests('asks'),
    );
  }

  @override
  String toString() {
    return 'StreamingOrderbook(figi: $figi, depth: $depth, '
        'bids: $bids, asks: $asks)';
  }
}

class StreamingOrderbookItem {
  final double price;
  final int quantity;

  StreamingOrderbookItem(this.price, this.quantity);

  factory StreamingOrderbookItem.fromJson(Map<String, dynamic> map) {
    return StreamingOrderbookItem(
      map.requireDouble('price'),
      map.requireInt('quantity'),
    );
  }

  @override
  String toString() =>
      'StreamingOrderbookItem(price: $price, quantity: $quantity)';
}

extension _FromJsonExtension on Map<String, dynamic> {
  List<StreamingOrderbookItem> requirePriceRequests(String key) =>
      (this[key] as List).map((dynamic e) {
        final item = e as List;
        return StreamingOrderbookItem(
          (item[0] as num).toDouble(),
          item[1] as int,
        );
      }).toList();
}
