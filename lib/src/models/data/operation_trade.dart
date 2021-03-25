import 'from_json.dart';

class OperationTrade {
  final String tradeId;
  final DateTime date;
  final double price;
  final int quantity;

  OperationTrade(this.tradeId, this.date, this.price, this.quantity);

  factory OperationTrade.fromJson(Map<String, dynamic> map) {
    return OperationTrade(
      map['tradeId'] as String,
      map.requireDateTime('date'),
      map.requireDouble('price'),
      map.requireInt('quantity'),
    );
  }

  @override
  String toString() {
    return 'OperationTrade(tradeId: $tradeId, date: $date, '
        'price: $price, quantity: $quantity)';
  }
}
