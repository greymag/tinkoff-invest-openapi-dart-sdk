import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_portfolio_endpoint.dart';
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
}
