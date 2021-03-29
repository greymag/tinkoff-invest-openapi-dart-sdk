import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_operations_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/operations_response.dart';

import 'dio_mock.dart';

void main() {
  group('load()', () {
    test('should return OperationsResponse on success with emty list',
        () async {
      const response =
          '{"trackingId":"e36882cda702ae7f","payload":{"operations":[]},"status":"Ok"}';
      final endpoint = TIOperationsEndpoint(dioForSuccess(response));
      final from = DateTime(2021, 2);
      final to = DateTime(2021, 3, 15);

      final res = await endpoint.load(from, to);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<OperationsResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'e36882cda702ae7f');
      expect(data.status, 'Ok');
      expect(data.payload.operations.length, 0);
    });

    // TODO: test params for send

    // TODO: test with figi

    // TODO: test with brokerAccountId

    // TODO: test with filled list

    // TODO: test fail
  });
}
