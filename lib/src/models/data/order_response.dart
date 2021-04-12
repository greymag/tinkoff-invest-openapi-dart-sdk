import '../from_json.dart';

class OrderResponse {
  final double price;
  final int quantity;

  OrderResponse(this.price, this.quantity);

  factory OrderResponse.fromJson(Map<String, dynamic> map) {
    return OrderResponse(
      map.requireDouble('price'),
      map.requireInt('quantity'),
    );
  }

  @override
  String toString() => 'OrderResponse(price: $price, quantity: $quantity)';
}
