import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_orders_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/empty_response.dart';
import 'package:tinkoff_invest/src/models/response/limit_order_response.dart';
import 'package:tinkoff_invest/src/models/response/market_order_response.dart';
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

    // TODO: test with not empty response

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

    // TODO: test params

    test('should return ErrorResponse on fail', () async {
      const response =
          '{"trackingId":"165f91f3d8b373a9","payload":{"message":"Cannot process request, not enough balance on security=USD","code":"NOT_ENOUGH_BALANCE"},"status":"Error"}';
      final endpoint = TIOrdersEndpoint(dioForError(response));

      final res =
          await endpoint.limitOrder('BBG000BPL8G3', OperationType.buy, 100, 1);

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

  group('marketOrder()', () {
    test('should return PlacedLimitOrder on success', () async {
      const response =
          '{"trackingId":"c03b657045275cd1","payload":{"orderId":"ed9c5925-2202-4dca-9471-4391dc6b8ca5","operation":"Sell","status":"New","requestedLots":1,"executedLots":0},"status":"Ok"}';
      final endpoint = TIOrdersEndpoint(dioForSuccess(response));

      final res =
          await endpoint.marketOrder('BBG000BPL8G3', OperationType.sell, 1);

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<MarketOrderResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'c03b657045275cd1');
      expect(data.status, 'Ok');
      expect(
          data.payload,
          PlacedMarketOrderMatcher.sell(
            orderId: 'ed9c5925-2202-4dca-9471-4391dc6b8ca5',
            status: OrderStatus.newOrder,
            requestedLots: 1,
            executedLots: 0,
          ));
    });

    // TODO: test params

    test('should return ErrorResponse on fail', () async {
      const response =
          '{"trackingId":"339943d55416a483","payload":{"message":"Cannot process request, not enough balance on security=USD","code":"NOT_ENOUGH_BALANCE"},"status":"Error"}';
      final endpoint = TIOrdersEndpoint(dioForError(response));

      final res =
          await endpoint.marketOrder('BBG000BPL8G3', OperationType.buy, 1);

      expect(res.isValue, false);
      expect(
          res.asError!.error,
          ErrorResponseMatcher(
            trackingId: '339943d55416a483',
            message:
                'Cannot process request, not enough balance on security=USD',
            code: 'NOT_ENOUGH_BALANCE',
          ));
    });
  });

  group('cancel()', () {
    test('should return empty response on success', () async {
      const response =
          '{"trackingId":"61cb1f0496add949","payload":{},"status":"Ok"}';
      final endpoint = TIOrdersEndpoint(dioForSuccess(response));

      final res = await endpoint.cancel('ed9c5925-2202-4dca-9471-4391dc6b8ca5');

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<EmptyResponse>());
    });

    // TODO: test brokerAccountId param

    test('should return ErrorResponse on fail', () async {
      const response =
          '{"trackingId":"3b8f216ac284ab51","payload":{"message":"Cannot find order by id someId","code":"ORDER_ERROR"},"status":"Error"}';
      final endpoint = TIOrdersEndpoint(dioForError(response));

      final res = await endpoint.cancel('someId');

      expect(res.isValue, false);
      expect(
          res.asError!.error,
          ErrorResponseMatcher(
            trackingId: '3b8f216ac284ab51',
            message: 'Cannot find order by id someId',
            code: 'ORDER_ERROR',
          ));
    });
  });
}
