import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_portfolio_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/portfolio_currencies_response.dart';
import 'package:tinkoff_invest/src/models/response/portfolio_response.dart';

import 'dio_mock.dart';
import 'matchers.dart';

void main() {
  group('load()', () {
    test('should return PortfolioResponse on success with no positions',
        () async {
      const response =
          '{"trackingId":"ee8f62931e14e49c","payload":{"positions":[]},"status":"Ok"}';
      final endpoint = TIPortfolioEndpoint(dioForSuccess(response));

      final res = await endpoint.load();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<PortfolioResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'ee8f62931e14e49c');
      expect(data.status, 'Ok');
      expect(data.payload.positions.length, 0);
    });

    // TODO: test with portfolio positions

    // TODO: test with parameter

    test('should return ErrorResponse on error', () async {
      const response =
          '{"trackingId":"0eb72e1061b533ac","payload":{"message":"Unknown account","code":"GATEWAY_REQUEST_DATA_ERROR"},"status":"Error"}';
      final endpoint = TIPortfolioEndpoint(dioForError(response));

      final res = await endpoint.load();

      expect(res.isError, true);
      expect(
        res.asError!.error,
        ErrorResponseMatcher(
          trackingId: '0eb72e1061b533ac',
          code: 'GATEWAY_REQUEST_DATA_ERROR',
          message: 'Unknown account',
        ),
      );
    });
  });

  group('currencies()', () {
    test(
        'should return PortfolioCurrenciesResponse on success with no positions',
        () async {
      const response =
          '{"trackingId":"4a214ba15f2a346d","payload":{"currencies":[{"currency":"EUR","balance":0},{"currency":"RUB","balance":2},{"currency":"USD","balance":5,"blocked":3}]},"status":"Ok"}';
      final endpoint = TIPortfolioEndpoint(dioForSuccess(response));

      final res = await endpoint.currencies();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<PortfolioCurrenciesResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '4a214ba15f2a346d');
      expect(data.status, 'Ok');
      expect(data.payload.currencies.length, 3);
      expect(
        data.payload.currencies[0],
        CurrencyPositionMatcher(Currency.EUR, 0),
      );
      expect(
        data.payload.currencies[1],
        CurrencyPositionMatcher(Currency.RUB, 2),
      );
      expect(
        data.payload.currencies[2],
        CurrencyPositionMatcher(Currency.USD, 5, 3),
      );
    });

    // TODO: test with parameter

    test('should return ErrorResponse on error', () async {
      const response =
          '{"trackingId":"20b96b76b1e05278","payload":{"message":"Invalid account","code":"REQUEST_DATA_ERROR"},"status":"Error"}';
      final endpoint = TIPortfolioEndpoint(dioForError(response));

      final res = await endpoint.currencies();

      expect(res.isError, true);
      expect(
        res.asError!.error,
        ErrorResponseMatcher(
          trackingId: '20b96b76b1e05278',
          code: 'REQUEST_DATA_ERROR',
          message: 'Invalid account',
        ),
      );
    });
  });
}
