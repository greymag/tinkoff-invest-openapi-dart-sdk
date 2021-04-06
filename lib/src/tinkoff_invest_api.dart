import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_market_endpoint.dart';
import 'package:tinkoff_invest/src/endpoints/ti_operations_endpoint.dart';
import 'package:tinkoff_invest/src/endpoints/ti_portfolio_endpoint.dart';
import 'package:tinkoff_invest/src/endpoints/ti_sandbox_endpoint.dart';
import 'package:tinkoff_invest/src/endpoints/ti_user_endpoint.dart';

import 'endpoints/ti_orders_endpoint.dart';

/// Tinkoff Invest Open API client.
///
/// https://github.com/TinkoffCreditSystems/invest-openapi
class TinkoffInvestApi {
  final TinkoffInvestApiConfig config;
  final String token;
  final bool sandboxMode;
  final bool debug;

  Dio? _dio;

  TISandboxEndpoint? _sandboxEndpoint;
  TIOrdersEndpoint? _ordersEndpoint;
  TIPortfolioEndpoint? _portfolioEndpoint;
  TIMarketEndpoint? _marketEndpoint;
  TIOperationsEndpoint? _operationsEndpoint;
  TIUserEndpoint? _userEndpoint;

  TinkoffInvestApi(
    this.token, {
    this.sandboxMode = false,
    this.config = const TinkoffInvestApiConfig(),
    this.debug = false,
  });

  Dio _getDio() {
    var res = _dio;
    if (res == null) {
      final options = BaseOptions(
        baseUrl: sandboxMode ? config.sandboxRestUrl : config.productionRestUrl,
        connectTimeout: const Duration(seconds: 3).inMilliseconds,
        headers: <String, Object>{
          'Authorization': 'Bearer $token',
        },
      );

      res = Dio(options);

      if (debug) {
        res.interceptors
            .add(LogInterceptor(responseBody: true, requestBody: true));
      }
    }

    return res;
  }

  /// Операции в sandbox.
  ///
  /// Если инстация была создана с [sandboxMode] равным `false`,
  /// то любое обращение к этому полю породит [StateError].
  TISandboxEndpoint get sandbox {
    if (_sandboxEndpoint == null) {
      if (!sandboxMode) {
        throw StateError('Api is not in Sandbox mode. '
            'You should create instance with sandBox: true '
            'if you want to use this endpoint.');
      }

      _sandboxEndpoint = TISandboxEndpoint(_getDio());
    }

    return _sandboxEndpoint!;
  }

  /// Операции заявок.
  TIOrdersEndpoint get orders =>
      _ordersEndpoint ??= TIOrdersEndpoint(_getDio());

  /// Операции с портфелем пользователя.
  TIPortfolioEndpoint get portfolio =>
      _portfolioEndpoint ??= TIPortfolioEndpoint(_getDio());

  /// Получение информации по бумагам.
  TIMarketEndpoint get market =>
      _marketEndpoint ??= TIMarketEndpoint(_getDio());

  /// Получение информации по операциям.
  TIOperationsEndpoint get operations =>
      _operationsEndpoint ??= TIOperationsEndpoint(_getDio());

  /// Получение информации по брокерским счетам.
  TIUserEndpoint get user => _userEndpoint ??= TIUserEndpoint(_getDio());
}

class TinkoffInvestApiConfig {
  final String productionRestUrl;
  final String productionStreamingUrl;
  final String sandboxRestUrl;

  const TinkoffInvestApiConfig({
    this.productionRestUrl = 'https://api-invest.tinkoff.ru/openapi/',
    this.productionStreamingUrl =
        'wss://api-invest.tinkoff.ru/openapi/md/v1/md-openapi/ws/',
    this.sandboxRestUrl = 'https://api-invest.tinkoff.ru/openapi/sandbox/',
  });
}
