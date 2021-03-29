import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_sandbox_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/sandbox_register_response.dart';

import 'dio_mock.dart';

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
}
