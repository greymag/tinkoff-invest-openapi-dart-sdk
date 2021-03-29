import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/operations_response.dart';

/// Endpoint /operations
///
/// Получение информации по операциям.
class TIOperationsEndpoint extends TIEndpoint {
  TIOperationsEndpoint(Dio dio) : super(dio, 'operations');

  /// Получение списка операций
  ///
  /// [from] Начало временного промежутка.
  /// [to] Конец временного промежутка.
  ///
  /// [figi] Figi инструмента для фильтрации.
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<OperationsResponse>> load(DateTime from, DateTime to,
      {String? figi, String? brokerAccountId}) async {
    final params = {'from': dateParam(from), 'to': dateParam(to)};
    if (figi != null) params['figi'] = figi;
    if (brokerAccountId != null) params['brokerAccountId'] = brokerAccountId;
    return get((d) => OperationsResponse.fromJson(d), params: params);
  }
}
