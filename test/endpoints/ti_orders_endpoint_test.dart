import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_orders_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/orders_response.dart';

import 'dio_mock.dart';

void main() {
  group('load()', () {
    test('should return OrdersResponse on success with empty list', () async {
      const response =
          '{"trackingId":"abdb2e769570bc80","payload":[],"status":"Ok"}';
      final endpoint = TIOrdersEndpoint(dioForSuccess(response));

      final res = await endpoint.load();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<OrdersResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'abdb2e769570bc80');
      expect(data.status, 'Ok');
      expect(data.payload.isEmpty, true);
    });

    // TODO: test with not empty rrsponse

    // TODO: test brokerAccountId param

    // TODO: test fail
  });
}
