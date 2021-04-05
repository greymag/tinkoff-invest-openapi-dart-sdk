import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/user_accounts_response.dart';

/// Endpoint /user
///
/// Получении информации по брокерским счетам.
class TIUserEndpoint extends TIEndpoint {
  TIUserEndpoint(Dio dio) : super(dio, 'user');

  /// Получение списка акций.
  Future<Result<UserAccountsResponse>> accounts() {
    return get((d) => UserAccountsResponse.fromJson(d), path: 'accounts');
  }
}
