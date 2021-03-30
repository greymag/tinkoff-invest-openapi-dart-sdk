import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_sandbox_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/empty_response.dart';
import 'package:tinkoff_invest/src/models/response/sandbox_register_response.dart';

import 'dio_mock.dart';
import 'matchers.dart';

void main() {
  group('register()', () {
    test('should return SandboxRegisterResponse on success', () async {
      const response =
          '{"trackingId":"9d14f022c143b982","payload":{"brokerAccountType":"Tinkoff","brokerAccountId":"SB2936272"},"status":"Ok"}';
      final endpoint = TISandboxEndpoint(dioForSuccess(response));

      final res = await endpoint.register();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<SandboxRegisterResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '9d14f022c143b982');
      expect(data.status, 'Ok');
      expect(data.payload.brokerAccountType, BrokerAccountType.tinkoff);
      expect(data.payload.brokerAccountId, 'SB2936272');
    });

    // TODO: test that request with POST method

    // TODO: test fail
  });

  group('currenciesBalance()', () {
    test('should return EmptyResponse on success', () async {
      const response =
          '{"trackingId":"61cb1f0496add949","payload":{},"status":"Ok"}';
      final endpoint = TISandboxEndpoint(dioForSuccess(response));

      final res = await endpoint.currenciesBalance(Currency.USD, 150);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<EmptyResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '61cb1f0496add949');
      expect(data.status, 'Ok');
    });

    // TODO: test that request with POST method

    // TODO: test arguments

    // TODO: test fail
  });

  group('positionsBalance()', () {
    test('should return EmptyResponse on success', () async {
      const response =
          '{"trackingId":"61cb1f0496add349","payload":{},"status":"Ok"}';
      final endpoint = TISandboxEndpoint(dioForSuccess(response));

      final res = await endpoint.positionsBalance('demo', 10);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<EmptyResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, '61cb1f0496add349');
      expect(data.status, 'Ok');
    });

    // TODO: test that request with POST method

    // TODO: test arguments

    test('should return ErrorResponse on fail', () async {
      const response =
          ' {"trackingId":"a91e78b9492ea43e","payload":{"message":"Cannot find security by id demo","code":"INSTRUMENT_ERROR"},"status":"Error"}';
      final endpoint = TISandboxEndpoint(dioForError(response));

      final res = await endpoint.positionsBalance('demo', 10);

      expect(res.isValue, false);
      expect(
          res.asError!.error,
          ErrorResponseMatcher(
            trackingId: 'a91e78b9492ea43e',
            message: 'Cannot find security by id demo',
            code: 'INSTRUMENT_ERROR',
          ));
    });
  });
}
