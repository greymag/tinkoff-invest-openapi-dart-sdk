import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/empty_response.dart';
import 'package:tinkoff_invest/src/models/response/limit_order_response.dart';
import 'package:tinkoff_invest/src/models/response/market_order_response.dart';
import 'package:tinkoff_invest/src/models/response/orders_response.dart';

/// Endpoint /orders
///
/// Операции заявок.
class TIOrdersEndpoint extends TIEndpoint {
  TIOrdersEndpoint(Dio dio) : super(dio, 'orders');

  /// Получение списка активных заявок.
  ///
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<OrdersResponse>> load([String? brokerAccountId]) {
    final params = optionalAccountIdParams(brokerAccountId);
    return get((d) => OrdersResponse.fromJson(d), params: params);
  }

  /// Создание лимитной заявки.
  ///
  /// [figi] FIGI инструмента.
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  ///
  /// Возвращает созданную заявку.
  Future<Result<LimitOrderResponse>> limitOrder(
      String figi, OperationType operation, double price, int lots,
      [String? brokerAccountId]) {
    final params = <String, Object>{'figi': figi};
    if (brokerAccountId != null) params['brokerAccountId'] = brokerAccountId;

    return post(
      (d) => LimitOrderResponse.fromJson(d),
      path: 'limit-order',
      queryParams: params,
      data: {
        'lots': lots,
        'operation': operation.toJson(),
        'price': price,
      },
    );
  }

  /// Создание рыночной заявки.
  ///
  /// [figi] FIGI инструмента.
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  ///
  /// Возвращает созданную заявку.
  Future<Result<MarketOrderResponse>> marketOrder(
      String figi, OperationType operation, int lots,
      [String? brokerAccountId]) {
    final params = <String, Object>{'figi': figi};
    if (brokerAccountId != null) params['brokerAccountId'] = brokerAccountId;

    return post(
      (d) => MarketOrderResponse.fromJson(d),
      path: 'market-order',
      queryParams: params,
      data: {
        'lots': lots,
        'operation': operation.toJson(),
      },
    );
  }

  /// Отмена заявки.
  ///
  /// [orderId] ID заявки.
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<EmptyResponse>> cancel(String orderId,
      [String? brokerAccountId]) {
    final params = <String, Object>{'orderId': orderId};
    if (brokerAccountId != null) params['brokerAccountId'] = brokerAccountId;

    return voidPost(
      path: 'cancel',
      queryParams: params,
    );
  }
}
