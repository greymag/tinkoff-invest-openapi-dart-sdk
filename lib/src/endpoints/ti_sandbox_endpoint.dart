import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/empty_response.dart';
import 'package:tinkoff_invest/src/models/response/sandbox_register_response.dart';

/// Endpoint /sandbox
///
/// Операция в sandbox.
class TISandboxEndpoint extends TIEndpoint {
  TISandboxEndpoint(Dio dio) : super(dio, 'sandbox');

  /// Регистрация клиента в sandbox.
  ///
  /// Создание счета и валютных позиций для клиента.
  Future<Result<SandboxRegisterResponse>> register() async {
    return post((d) => SandboxRegisterResponse.fromJson(d), path: 'register');
  }

  /// Выставление баланса по валютным позициям.
  ///
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<EmptyResponse>> currenciesBalance(
      Currency currency, double balance,
      [String? brokerAccountId]) async {
    return post(
      (d) => EmptyResponse.fromJson(d),
      path: 'currencies/balance',
      data: <String, Object>{
        'currency': currency.toJson(),
        'balance': balance,
      },
      queryParams: optionalAccountIdParams(brokerAccountId),
    );
  }
}
