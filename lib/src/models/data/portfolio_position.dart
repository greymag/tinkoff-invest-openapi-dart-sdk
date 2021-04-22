import 'instrument_type.dart';
import 'money_amount.dart';
import '../from_json.dart';

class PortfolioPosition {
  final String figi;
  final String? ticker;
  final String? isin;
  final InstrumentType instrumentType;
  final double balance;
  final double? blocked;
  final MoneyAmount? expectedYield;
  final int lots;
  final MoneyAmount? averagePositionPrice;
  final MoneyAmount? averagePositionPriceNoNkd;
  final String name;

  PortfolioPosition(
      this.figi,
      this.ticker,
      this.isin,
      this.instrumentType,
      this.balance,
      this.blocked,
      this.expectedYield,
      this.lots,
      this.averagePositionPrice,
      this.averagePositionPriceNoNkd,
      this.name);

  factory PortfolioPosition.fromJson(Map<String, dynamic> data) =>
      PortfolioPosition(
        data['figi'] as String,
        data['ticker'] as String?,
        data['isin'] as String?,
        const InstrumentTypeConverter()
            .convert(data['instrumentType'] as String),
        data.requireDouble('balance'),
        data.optionalDouble('blocked'),
        data.optional('expectedYield', (d) => MoneyAmount.fromJson(d)),
        data['lots'] as int,
        data.optional('averagePositionPrice', (d) => MoneyAmount.fromJson(d)),
        data.optional(
            'averagePositionPriceNoNkd', (d) => MoneyAmount.fromJson(d)),
        data['name'] as String,
      );

  @override
  String toString() {
    return 'PortfolioPosition(figi: $figi, ticker: $ticker, isin: $isin, '
        'instrumentType: $instrumentType, balance: $balance, '
        'blocked: $blocked, expectedYield: $expectedYield, lots: $lots, '
        'averagePositionPrice: $averagePositionPrice, '
        'averagePositionPriceNoNkd: $averagePositionPriceNoNkd, name: $name)';
  }
}
