import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_orders_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/limit_order_response.dart';
import 'package:tinkoff_invest/src/models/response/orders_response.dart';

import 'dio_mock.dart';
import 'matchers.dart';

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

  group('limitOrder()', () {
    test('should return LimitOrderResponse on success', () async {
      const response =
          '{"trackingId":"d27707f77f901645","payload":{"orderId":"dfd0c066-6d1e-4da0-af1c-eab27beaec89","operation":"Buy","status":"Fill","requestedLots":1,"executedLots":1},"status":"Ok"}';
      final endpoint = TIOrdersEndpoint(dioForSuccess(response));

      final res =
          await endpoint.limitOrder('BBG000BPL8G3', OperationType.buy, 100, 1);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<LimitOrderResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'd27707f77f901645');
      expect(data.status, 'Ok');
      expect(
          data.payload,
          PlacedLimitOrderMatcher.buy(
            orderId: 'dfd0c066-6d1e-4da0-af1c-eab27beaec89',
            status: OrderStatus.fill,
            requestedLots: 1,
            executedLots: 1,
          ));
    });

    // TODO: test with not empty rrsponse

    // TODO: test brokerAccountId param

    test('should return ErrorResponse on fail', () async {
      const response =
          '{"trackingId":"165f91f3d8b373a9","payload":{"message":"Cannot process request, not enough balance on security=USD","code":"NOT_ENOUGH_BALANCE"},"status":"Error"}';
      final endpoint = TIOrdersEndpoint(dioForError(response));

      final res = await endpoint.load();

      expect(res.isValue, false);
      expect(
          res.asError!.error,
          ErrorResponseMatcher(
            trackingId: '165f91f3d8b373a9',
            message:
                'Cannot process request, not enough balance on security=USD',
            code: 'NOT_ENOUGH_BALANCE',
          ));
    });
  });
}
