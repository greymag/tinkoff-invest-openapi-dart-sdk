import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/operations_response.dart';

/// Endpoint /operations
class TIOperationsEndpoint extends TIEndpoint {
  TIOperationsEndpoint(Dio dio) : super(dio, 'operations');

  /// Получение списка операций
  ///
  /// [from] Начало временного промежутка (2019-08-19T18:38:33.131642+03:00).
  /// [to] Конец временного промежутка (2019-08-19T18:38:33.131642+03:00).
  ///
  /// [figi] Figi инструмента для фильтрации.
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<OperationsResponse>> load(DateTime from, DateTime to,
      {String? figi, String? brokerAccountId}) async {
    // XXX: from/to переделать на DateTime
    final params = {'from': dateParam(from), 'to': dateParam(to)};
    if (figi != null) params['figi'] = figi;
    if (brokerAccountId != null) params['brokerAccountId'] = brokerAccountId;
    return get((d) => OperationsResponse.fromJson(d), params: params);
  }
}
