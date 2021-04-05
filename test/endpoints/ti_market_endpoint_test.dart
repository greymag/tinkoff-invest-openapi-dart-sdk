import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_market_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/candles_response.dart';
import 'package:tinkoff_invest/src/models/response/market_instrument_list_response.dart';
import 'package:tinkoff_invest/src/models/response/orderbook_response.dart';
import 'package:tinkoff_invest/src/models/response/search_market_instrument_response.dart';

import 'dio_mock.dart';
import 'matchers.dart';

void main() {
  group('stocks()', () {
    test('should return MarketInstrumentListResponse on success', () async {
      const response =
          '{"trackingId":"42267434aec67f6d","payload":{"instruments":[{"figi":"BBG000HLJ7M4","ticker":"IDCC","isin":"US45867G1013","minPriceIncrement":0.01,"lot":1,"currency":"USD","name":"InterDigItal Inc","type":"Stock"},{"figi":"BBG004S68758","ticker":"BANE","isin":"RU0007976957","minPriceIncrement":0.5,"lot":1,"currency":"RUB","name":"Башнефть","type":"Stock"},{"figi":"BBG000BPL8G3","ticker":"MTSC","isin":"US5537771033","minPriceIncrement":0.01,"lot":1,"currency":"USD","name":"MTS Systems Corp","type":"Stock"}],"total":3},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.stocks();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketInstrumentListResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '42267434aec67f6d');
      expect(data.status, 'Ok');
      expect(data.payload.total, 3);
      expect(data.payload.instruments.length, 3);
      expect(
          data.payload.instruments[0],
          MarketInstrumentMatcher.stock(
            figi: 'BBG000HLJ7M4',
            ticker: 'IDCC',
            isin: 'US45867G1013',
            minPriceIncrement: 0.01,
            lot: 1,
            currency: Currency.USD,
            name: 'InterDigItal Inc',
          ));
      expect(
          data.payload.instruments[1],
          MarketInstrumentMatcher.stock(
            figi: 'BBG004S68758',
            ticker: 'BANE',
            isin: 'RU0007976957',
            minPriceIncrement: 0.5,
            lot: 1,
            currency: Currency.RUB,
            name: 'Башнефть',
          ));
      expect(
          data.payload.instruments[2],
          MarketInstrumentMatcher.stock(
            figi: 'BBG000BPL8G3',
            ticker: 'MTSC',
            isin: 'US5537771033',
            minPriceIncrement: 0.01,
            lot: 1,
            currency: Currency.USD,
            name: 'MTS Systems Corp',
          ));
    });

    // TODO: test fail
  });

  group('bonds()', () {
    test('should return MarketInstrumentListResponse on success', () async {
      const response =
          '{"trackingId":"cf00b0e801014ec1","payload":{"instruments":[{"figi":"BBG00T22WKV5","ticker":"SU29013RMFS8","isin":"RU000A101KT1","minPriceIncrement":0.01,"faceValue":1000.0,"lot":1,"currency":"RUB","name":"ОФЗ 29013","type":"Bond"},{"figi":"XS2091668447","ticker":"XS2091668447","isin":"XS2091668447","minPriceIncrement":0.00125,"faceValue":1250.0,"lot":1,"currency":"USD","name":"BCS Structured Products 30dec2024","type":"Bond"},{"figi":"BBG00N8HZBK8","ticker":"CBOM0224EU","isin":"XS1951067039","minPriceIncrement":0.1,"faceValue":1000.0,"lot":1,"currency":"EUR","name":"Credit Bank of Moscow","type":"Bond"}],"total":3},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.bonds();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketInstrumentListResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'cf00b0e801014ec1');
      expect(data.status, 'Ok');
      expect(data.payload.total, 3);
      expect(data.payload.instruments.length, 3);
      expect(
          data.payload.instruments[0],
          MarketInstrumentMatcher.bond(
            figi: 'BBG00T22WKV5',
            ticker: 'SU29013RMFS8',
            isin: 'RU000A101KT1',
            minPriceIncrement: 0.01,
            faceValue: 1000.0,
            lot: 1,
            currency: Currency.RUB,
            name: 'ОФЗ 29013',
          ));
      expect(
          data.payload.instruments[1],
          MarketInstrumentMatcher.bond(
            figi: 'XS2091668447',
            ticker: 'XS2091668447',
            isin: 'XS2091668447',
            minPriceIncrement: 0.00125,
            faceValue: 1250.0,
            lot: 1,
            currency: Currency.USD,
            name: 'BCS Structured Products 30dec2024',
          ));
      expect(
          data.payload.instruments[2],
          MarketInstrumentMatcher.bond(
            figi: 'BBG00N8HZBK8',
            ticker: 'CBOM0224EU',
            isin: 'XS1951067039',
            minPriceIncrement: 0.1,
            faceValue: 1000.0,
            lot: 1,
            currency: Currency.EUR,
            name: 'Credit Bank of Moscow',
          ));
    });

    // TODO: test fail
  });

  group('etfs()', () {
    test('should return MarketInstrumentListResponse on success', () async {
      const response =
          '{"trackingId":"410ead15ce71862c","payload":{"instruments":[{"figi":"BBG333333333","ticker":"TMOS","isin":"RU000A101X76","minPriceIncrement":0.002,"lot":1,"currency":"RUB","name":"Тинькофф iMOEX","type":"Etf"},{"figi":"BBG00M0DNJ69","ticker":"RU000A0JR282","isin":"RU000A0JR282","minPriceIncrement":0.05,"lot":100,"currency":"RUB","name":"ВТБ Капитал – Фонд Акций","type":"Etf"},{"figi":"BBG00P5M77Y0","ticker":"AKSP","isin":"RU000A1006V3","minPriceIncrement":0.01,"lot":1,"currency":"USD","name":"Альфа-Капитал S&P 500","type":"Etf"}],"total":3},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.etfs();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketInstrumentListResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '410ead15ce71862c');
      expect(data.status, 'Ok');
      expect(data.payload.total, 3);
      expect(data.payload.instruments.length, 3);
      expect(
          data.payload.instruments[0],
          MarketInstrumentMatcher.etf(
            figi: 'BBG333333333',
            ticker: 'TMOS',
            isin: 'RU000A101X76',
            minPriceIncrement: 0.002,
            lot: 1,
            currency: Currency.RUB,
            name: 'Тинькофф iMOEX',
          ));
      expect(
          data.payload.instruments[1],
          MarketInstrumentMatcher.etf(
            figi: 'BBG00M0DNJ69',
            ticker: 'RU000A0JR282',
            isin: 'RU000A0JR282',
            minPriceIncrement: 0.05,
            lot: 100,
            currency: Currency.RUB,
            name: 'ВТБ Капитал – Фонд Акций',
          ));
      expect(
          data.payload.instruments[2],
          MarketInstrumentMatcher.etf(
            figi: 'BBG00P5M77Y0',
            ticker: 'AKSP',
            isin: 'RU000A1006V3',
            minPriceIncrement: 0.01,
            lot: 1,
            currency: Currency.USD,
            name: 'Альфа-Капитал S&P 500',
          ));
    });

    // TODO: test fail
  });

  group('currencies()', () {
    test('should return MarketInstrumentListResponse on success', () async {
      const response =
          '{"trackingId":"9019eb4f65462ea8","payload":{"instruments":[{"figi":"BBG0013HGFT4","ticker":"USD000UTSTOM","minPriceIncrement":0.0025,"lot":1000,"currency":"RUB","name":"Доллар США","type":"Currency"},{"figi":"BBG0013HJJ31","ticker":"EUR_RUB__TOM","minPriceIncrement":0.0025,"lot":1000,"currency":"RUB","name":"Евро","type":"Currency"}],"total":2},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.currencies();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketInstrumentListResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '9019eb4f65462ea8');
      expect(data.status, 'Ok');
      expect(data.payload.total, 2);
      expect(data.payload.instruments.length, 2);
      expect(
          data.payload.instruments[0],
          MarketInstrumentMatcher.currency(
            figi: 'BBG0013HGFT4',
            ticker: 'USD000UTSTOM',
            minPriceIncrement: 0.0025,
            lot: 1000,
            currency: Currency.RUB,
            name: 'Доллар США',
          ));
      expect(
          data.payload.instruments[1],
          MarketInstrumentMatcher.currency(
            figi: 'BBG0013HJJ31',
            ticker: 'EUR_RUB__TOM',
            minPriceIncrement: 0.0025,
            lot: 1000,
            currency: Currency.RUB,
            name: 'Евро',
          ));
    });

    // TODO: test fail
  });

  group('orderbook()', () {
    test('should return OrderbookResponse on success for not available',
        () async {
      const response =
          '{"trackingId":"768a69ea957e159d","payload":{"figi":"BBG004S68758","depth":10,"tradeStatus":"NotAvailableForTrading","minPriceIncrement":0.5,"lastPrice":1632.5,"closePrice":1632.5,"bids":[],"asks":[]},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.orderbook('BBG004S68758', 10);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<OrderbookResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '768a69ea957e159d');
      expect(data.status, 'Ok');
      expect(
          data.payload,
          OrderbookMatcher(
            figi: 'BBG004S68758',
            depth: 10,
            tradeStatus: TradeStatus.notAvailableForTrading,
            minPriceIncrement: 0.5,
            lastPrice: 1632.5,
            closePrice: 1632.5,
            bids: [],
            asks: [],
          ));
    });

    test('should return OrderbookResponse on success for available', () async {
      const response =
          '{"trackingId":"6a20672862fdb760","payload":{"figi":"BBG000BPL8G3","depth":2,"tradeStatus":"NormalTrading","minPriceIncrement":0.01,"lastPrice":58.19,"closePrice":58.2,"limitUp":60.0,"limitDown":57,"bids":[{"price":58.18,"quantity":539},{"price":58.17,"quantity":156}],"asks":[{"price":58.2,"quantity":625},{"price":58.22,"quantity":7}]},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.orderbook('BBG000BPL8G3', 2);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<OrderbookResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '6a20672862fdb760');
      expect(data.status, 'Ok');
      expect(
          data.payload,
          OrderbookMatcher(
            figi: 'BBG000BPL8G3',
            depth: 2,
            tradeStatus: TradeStatus.normalTrading,
            minPriceIncrement: 0.01,
            lastPrice: 58.19,
            closePrice: 58.2,
            limitUp: 60.0,
            limitDown: 57,
            bids: [
              OrderResponse(58.18, 539),
              OrderResponse(58.17, 156),
            ],
            asks: [
              OrderResponse(58.2, 625),
              OrderResponse(58.22, 7),
            ],
          ));
    });

    // TODO: test fail
  });

  group('candles()', () {
    test('should return OrderbookResponse on success', () async {
      const response =
          '{"trackingId":"4ad6e79ee3f69d1c","payload":{"candles":[{"o":58.06,"c":58.06,"h":58.06,"l":58.06,"v":1,"time":"2021-04-01T10:00:00Z","interval":"30min","figi":"BBG000BPL8G3"},{"o":58.21,"c":58.21,"h":58.21,"l":58.21,"v":3,"time":"2021-04-01T15:30:00Z","interval":"30min","figi":"BBG000BPL8G3"}],"interval":"30min","figi":"BBG000BPL8G3"},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.candles('BBG000BPL8G3', DateTime(2021, 4, 1),
          DateTime(2021, 4, 2), CandleResolution.thirtyMin);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<CandlesResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '4ad6e79ee3f69d1c');
      expect(data.status, 'Ok');

      expect(data.payload.figi, 'BBG000BPL8G3');
      expect(data.payload.interval, CandleResolution.thirtyMin);
      expect(data.payload.candles.length, 2);

      expect(
          data.payload.candles[0],
          CandleMatcher.thirtyMin(
            figi: 'BBG000BPL8G3',
            o: 58.06,
            c: 58.06,
            h: 58.06,
            l: 58.06,
            v: 1,
            time: DateTime.utc(2021, 4, 1, 10).toLocal(),
          ));

      expect(
          data.payload.candles[1],
          CandleMatcher.thirtyMin(
            figi: 'BBG000BPL8G3',
            o: 58.21,
            c: 58.21,
            h: 58.21,
            l: 58.21,
            v: 3,
            time: DateTime.utc(2021, 4, 1, 15, 30).toLocal(),
          ));
    });

    // TODO: test fail
  });

  group('searchByFigi()', () {
    test('should return SearchMarketInstrumentResponse on success', () async {
      const response =
          '{"trackingId":"632ae8281908df56","payload":{"figi":"BBG004S68758","ticker":"BANE","isin":"RU0007976957","minPriceIncrement":0.5,"lot":1,"currency":"RUB","name":"Башнефть","type":"Stock"},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.searchByFigi('BBG004S68758');

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<SearchMarketInstrumentResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '632ae8281908df56');
      expect(data.status, 'Ok');

      expect(
          data.payload,
          SearchMarketInstrumentMatcher.stock(
            figi: 'BBG004S68758',
            ticker: 'BANE',
            isin: 'RU0007976957',
            minPriceIncrement: 0.5,
            lot: 1,
            currency: Currency.RUB,
            name: 'Башнефть',
          ));
    });

    // TODO: test fail
  });

  group('searchByTicker()', () {
    test('should return MarketInstrumentListResponse on success', () async {
      const response =
          '{"trackingId":"a418a6560fb00366","payload":{"instruments":[{"figi":"BBG00QPYJ5H0","ticker":"TCSG","isin":"TCS7238U2033","minPriceIncrement":0.2,"lot":1,"currency":"RUB","name":"TCS Group","type":"Stock"}],"total":1},"status":"Ok"}';
      final endpoint = TIMarketEndpoint(dioForSuccess(response));

      final res = await endpoint.searchByTicker('TCSG');

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketInstrumentListResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'a418a6560fb00366');
      expect(data.status, 'Ok');
      expect(data.payload.total, 1);
      expect(data.payload.instruments.length, 1);

      expect(
          data.payload.instruments[0],
          MarketInstrumentMatcher.stock(
            figi: 'BBG00QPYJ5H0',
            ticker: 'TCSG',
            isin: 'TCS7238U2033',
            minPriceIncrement: 0.2,
            lot: 1,
            currency: Currency.RUB,
            name: 'TCS Group',
          ));
    });

    // TODO: test fail
  });
}
