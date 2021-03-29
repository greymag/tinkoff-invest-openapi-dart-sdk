import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/portfolio_currencies_response.dart';
import 'package:tinkoff_invest/src/models/response/portfolio_response.dart';

/// Endpoint /portfolio
///
/// Операции с портфелем пользователя.
class TIPortfolioEndpoint extends TIEndpoint {
  TIPortfolioEndpoint(Dio dio) : super(dio, 'portfolio');

  /// Получение портфеля клиента.
  ///
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<PortfolioResponse>> load([String? brokerAccountId]) async {
    final params = optionalAccountIdParams(brokerAccountId);
    return get((d) => PortfolioResponse.fromJson(d), params: params);
  }

  /// Получение валютных активов клиента.
  ///
  /// [brokerAccountId] Номер счета (по умолчанию - Тинькофф).
  Future<Result<PortfolioCurrenciesResponse>> currencies(
      [String? brokerAccountId]) async {
    final params = optionalAccountIdParams(brokerAccountId);
    return get((d) => PortfolioCurrenciesResponse.fromJson(d),
        path: 'currencies', params: params);
  }
}
