import 'package:test/test.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/error_response.dart';

class ErrorResponseMatcher extends Matcher {
  final String trackingId;
  final String status;
  final String message;
  final String code;

  ErrorResponseMatcher(
      {required this.trackingId,
      required this.message,
      required this.code,
      this.status = 'Error'});

  @override
  Description describe(Description description) {
    return description.add(
        'ErrorResponse:<ErrorResponse(trackingId: $trackingId, '
        'status: $status, payload: ErrorData(code: $code, message: $message))>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! ErrorResponse) return false;

    return item.trackingId == trackingId &&
        item.status == status &&
        item.payload.code == code &&
        item.payload.message == message;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! ErrorResponse) {
      return mismatchDescription.add("is not an instance of 'ErrorResponse'");
    }

    final mismatch = <String>[
      if (item.trackingId != trackingId) 'trackingId',
      if (item.status != status) 'status',
      if (item.payload.code != code) 'payload.code',
      if (item.payload.message != message) 'payload.message',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}

class CurrencyPositionMatcher extends Matcher {
  final Currency currency;
  final double balance;
  final double? blocked;

  CurrencyPositionMatcher(this.currency, this.balance, [this.blocked]);

  @override
  Description describe(Description description) {
    return description
        .add('CurrencyPosition:<CurrencyPosition(currency: $currency, '
            'balance: $balance, blocked: $blocked)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! CurrencyPosition) return false;

    return item.currency == currency &&
        item.balance == balance &&
        item.blocked == blocked;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! CurrencyPosition) {
      return mismatchDescription
          .add("is not an instance of 'CurrencyPosition'");
    }

    final mismatch = <String>[
      if (item.currency != currency) 'currency',
      if (item.balance != balance) 'balance',
      if (item.blocked != blocked) 'blocked',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}

class MarketInstrumentMatcher extends Matcher {
  final String figi;
  final String ticker;
  final String? isin;
  final double? minPriceIncrement;
  final int lot;
  final int? minQuantity;
  final Currency? currency;
  final String name;
  final InstrumentType type;

  MarketInstrumentMatcher(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name,
      required this.type});

  MarketInstrumentMatcher.stock(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name})
      : type = InstrumentType.stock;

  MarketInstrumentMatcher.bond(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name})
      : type = InstrumentType.bond;

  MarketInstrumentMatcher.etf(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name})
      : type = InstrumentType.etf;

  @override
  Description describe(Description description) {
    return description.add(
        'MarketInstrument:<MarketInstrument(figi: $figi, ticker: $ticker, isin: $isin, '
        'minPriceIncrement: $minPriceIncrement, lot: $lot, '
        'minQuantity: $minQuantity, currency: $currency, name: $name, '
        'type: $type)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! MarketInstrument) return false;

    return item.figi == figi &&
        item.ticker == ticker &&
        item.isin == isin &&
        item.minPriceIncrement == minPriceIncrement &&
        item.lot == lot &&
        item.minQuantity == minQuantity &&
        item.currency == currency &&
        item.name == name &&
        item.type == type;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! MarketInstrument) {
      return mismatchDescription
          .add("is not an instance of 'MarketInstrument'");
    }

    final mismatch = <String>[
      if (item.figi != figi) 'figi',
      if (item.ticker != ticker) 'ticker',
      if (item.isin != isin) 'isin',
      if (item.minPriceIncrement != minPriceIncrement) 'minPriceIncrement',
      if (item.lot != lot) 'lot',
      if (item.minQuantity != minQuantity) 'minQuantity',
      if (item.currency != currency) 'currency',
      if (item.name != name) 'name',
      if (item.type != type) 'type',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}
