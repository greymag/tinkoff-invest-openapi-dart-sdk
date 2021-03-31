import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/market_instrument_list_response.dart';
import 'package:tinkoff_invest/src/models/response/orderbook_response.dart';

/// Endpoint /market
///
/// Получении информации по бумагам.
class TIMarketEndpoint extends TIEndpoint {
  TIMarketEndpoint(Dio dio) : super(dio, 'market');

  /// Получение списка акций.
  Future<Result<MarketInstrumentListResponse>> stocks() {
    return get((d) => MarketInstrumentListResponse.fromJson(d), path: 'stocks');
  }

  /// Получение списка облигаций.
  Future<Result<MarketInstrumentListResponse>> bonds() {
    return get((d) => MarketInstrumentListResponse.fromJson(d), path: 'bonds');
  }

  /// Получение списка ETF.
  Future<Result<MarketInstrumentListResponse>> etfs() {
    return get((d) => MarketInstrumentListResponse.fromJson(d), path: 'etfs');
  }

  /// Получение списка валютных пар.
  Future<Result<MarketInstrumentListResponse>> currencies() {
    return get((d) => MarketInstrumentListResponse.fromJson(d),
        path: 'currencies');
  }

  /// Получение стакана по FIGI.
  ///
  /// [figi] FIGI.
  /// [depth] Глубина стакана [1..20]
  Future<Result<OrderbookResponse>> orderbook(String figi, int depth) {
    assert(depth >= 1 && depth <= 20);
    return get(
      (d) => OrderbookResponse.fromJson(d),
      path: 'orderbook',
      params: <String, Object>{
        'figi': figi,
        'depth': depth,
      },
    );
  }
}
