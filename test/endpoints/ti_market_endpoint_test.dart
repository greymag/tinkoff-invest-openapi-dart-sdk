import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_market_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/market_instrument_list_response.dart';

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
            // faceValue: 1000.0
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
            // faceValue: 1250.0
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
            // faceValue: 1000.0
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
}
