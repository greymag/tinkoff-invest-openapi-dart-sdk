import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
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
}
