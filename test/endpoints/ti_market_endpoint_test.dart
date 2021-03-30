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
}
