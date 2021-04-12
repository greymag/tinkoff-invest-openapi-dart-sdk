import 'currency.dart';
import '../from_json.dart';
import 'instrument_type.dart';
import 'money_amount.dart';
import 'operation_status.dart';
import 'operation_trade.dart';
import 'operation_type_with_commission.dart';

class Operation {
  final String id;

  /// Статус заявки.
  final OperationStatus status;
  final List<OperationTrade> trades;
  final MoneyAmount? commission;
  final Currency currency;
  final double payment;
  final double? price;

  /// Число инструментов в выставленной заявке.
  final int? quantity;

  /// Число инструментов, исполненных в заявке.
  final int? quantityExecuted;
  final String? figi;
  final InstrumentType? instrumentType;
  final bool isMarginCall;
  final DateTime date;
  final OperationTypeWithCommission? operationType;

  Operation(
    this.id,
    this.status,
    this.trades,
    this.commission,
    this.currency,
    this.payment,
    this.price,
    this.quantity,
    this.quantityExecuted,
    this.figi,
    this.instrumentType,
    this.date,
    this.operationType, {
    required this.isMarginCall,
  });

  factory Operation.fromJson(Map<String, dynamic> map) {
    return Operation(
      map['id'] as String,
      map.requireOperationStatus(),
      map.requireList('trades', (x) => OperationTrade.fromJson(x)),
      map['commission'] != null
          ? MoneyAmount.fromJson(map['commission'] as Map<String, dynamic>)
          : null,
      map.requireCurrency(),
      map.requireDouble('payment'),
      map.optionalDouble('price'),
      map.optionalInt('quantity'),
      map.optionalInt('quantityExecuted'),
      map['figi'] as String?,
      map.optionalInstrumentType(),
      map.requireDateTime('date'),
      map.optionalOperationTypeWithCommission('operationType'),
      isMarginCall: map.requireBool('isMarginCall'),
    );
  }

  @override
  String toString() {
    return 'Operation(id: $id, status: $status, trades: $trades, '
        'commission: $commission, currency: $currency, payment: $payment, '
        'price: $price, quantity: $quantity, quantityExecuted: $quantityExecuted, '
        'figi: $figi, instrumentType: $instrumentType, '
        'isMarginCall: $isMarginCall, date: $date, operationType: $operationType)';
  }
}
