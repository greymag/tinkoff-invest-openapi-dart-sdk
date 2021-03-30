import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:tinkoff_invest/src/endpoints/ti_endpoint.dart';
import 'package:tinkoff_invest/src/models/response/market_instrument_list_response.dart';

/// Endpoint /market
///
/// Получении информации по бумагам.
class TIMarketEndpoint extends TIEndpoint {
  TIMarketEndpoint(Dio dio) : super(dio, 'market');

  /// Получение списка акций.
  Future<Result<MarketInstrumentListResponse>> stocks() {
    return get((d) => MarketInstrumentListResponse.fromJson(d), path: 'stocks');
  }
}
