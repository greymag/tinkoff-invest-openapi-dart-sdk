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
  final double? faceValue;
  final int lot;
  final int? minQuantity;
  final Currency? currency;
  final String name;
  final InstrumentType type;

  MarketInstrumentMatcher(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.faceValue,
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
      this.faceValue,
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
      this.faceValue,
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
      this.faceValue,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name})
      : type = InstrumentType.etf;

  MarketInstrumentMatcher.currency(
      {required this.figi,
      required this.ticker,
      this.isin,
      this.faceValue,
      this.minPriceIncrement,
      required this.lot,
      this.minQuantity,
      this.currency,
      required this.name})
      : type = InstrumentType.currency;

  @override
  Description describe(Description description) {
    return description
        .add('MarketInstrument:<MarketInstrument(figi: $figi, ticker: $ticker, '
            'isin: $isin, minPriceIncrement: $minPriceIncrement, '
            'faceValue: $faceValue, lot: $lot, minQuantity: $minQuantity, '
            'currency: $currency, name: $name, type: $type)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! MarketInstrument) return false;

    return item.figi == figi &&
        item.ticker == ticker &&
        item.isin == isin &&
        item.minPriceIncrement == minPriceIncrement &&
        item.faceValue == faceValue &&
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
      if (item.faceValue != faceValue) 'faceValue',
      if (item.lot != lot) 'lot',
      if (item.minQuantity != minQuantity) 'minQuantity',
      if (item.currency != currency) 'currency',
      if (item.name != name) 'name',
      if (item.type != type) 'type',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}

class OrderbookMatcher extends Matcher {
  final String figi;
  final int depth;
  final List<OrderResponse> bids;
  final List<OrderResponse> asks;
  final TradeStatus tradeStatus;
  final double minPriceIncrement;
  final double? faceValue;
  final double? lastPrice;
  final double? closePrice;
  final double? limitUp;
  final double? limitDown;

  OrderbookMatcher({
    required this.figi,
    required this.depth,
    required this.bids,
    required this.asks,
    required this.tradeStatus,
    required this.minPriceIncrement,
    this.faceValue,
    this.lastPrice,
    this.closePrice,
    this.limitUp,
    this.limitDown,
  });

  @override
  Description describe(Description description) {
    return description.add(
        'Orderbook:<Orderbook(figi: $figi, depth: $depth, bids: $bids, '
        'asks: $asks, tradeStatus: $tradeStatus, '
        'minPriceIncrement: $minPriceIncrement, faceValue: $faceValue, '
        'lastPrice: $lastPrice, closePrice: $closePrice, limitUp: $limitUp, '
        'limitDown: $limitDown)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! Orderbook) return false;

    return item.figi == figi &&
        item.depth == depth &&
        _isEquivivalent(item.bids, bids) &&
        _isEquivivalent(item.asks, asks) &&
        item.tradeStatus == tradeStatus &&
        item.minPriceIncrement == minPriceIncrement &&
        item.faceValue == faceValue &&
        item.lastPrice == lastPrice &&
        item.closePrice == closePrice &&
        item.limitUp == limitUp &&
        item.limitDown == limitDown;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! Orderbook) {
      return mismatchDescription.add("is not an instance of 'Orderbook'");
    }

    final mismatch = <String>[
      if (item.figi != figi) 'figi',
      if (item.depth != depth) 'depth',
      if (!_isEquivivalent(item.bids, bids)) 'bids',
      if (!_isEquivivalent(item.asks, asks)) 'asks',
      if (item.tradeStatus != tradeStatus) 'tradeStatus',
      if (item.minPriceIncrement != minPriceIncrement) 'minPriceIncrement',
      if (item.faceValue != faceValue) 'faceValue',
      if (item.lastPrice != lastPrice) 'lastPrice',
      if (item.closePrice != closePrice) 'closePrice',
      if (item.limitUp != limitUp) 'limitUp',
      if (item.limitDown != limitDown) 'limitDown',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }

  bool _isEquivivalent(List<OrderResponse> a, List<OrderResponse> b) {
    if (a.length != b.length) return false;

    final s = b.toList();
    for (final item in a) {
      final index = s.indexWhere(
          (e) => e.price == item.price && e.quantity == item.quantity);
      if (index == -1) return false;

      s.removeAt(index);
    }

    return true;
  }
}

class CandleMatcher extends Matcher {
  final String figi;
  final CandleResolution interval;
  final double o;
  final double c;
  final double h;
  final double l;
  final int v;
  final DateTime time;

  CandleMatcher({
    required this.figi,
    required this.interval,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.v,
    required this.time,
  });

  CandleMatcher.thirtyMin({
    required this.figi,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.v,
    required this.time,
  }) : interval = CandleResolution.thirtyMin;

  @override
  Description describe(Description description) {
    return description.add(
        'Candle:<Candle(figi: $figi, interval: $interval, o: $o, c: $c, h: $h, '
        'l: $l, v: $v, time: $time)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! Candle) return false;

    return item.figi == figi &&
        item.interval == interval &&
        item.o == o &&
        item.c == c &&
        item.h == h &&
        item.l == l &&
        item.v == v &&
        item.time == time;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! Candle) {
      return mismatchDescription.add("is not an instance of 'Candle'");
    }

    final mismatch = <String>[
      if (item.figi != figi) 'figi',
      if (item.interval != interval) 'interval',
      if (item.o != o) 'o',
      if (item.c != c) 'c',
      if (item.h != h) 'h',
      if (item.l != l) 'l',
      if (item.v != v) 'v',
      if (item.time != time) 'time',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}
