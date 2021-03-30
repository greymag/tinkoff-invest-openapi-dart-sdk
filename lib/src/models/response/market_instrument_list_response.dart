import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class MarketInstrumentListResponse extends StdResponse<MarketInstrumentList> {
  MarketInstrumentListResponse(
      String trackingId, String status, MarketInstrumentList payload)
      : super(trackingId, status, payload);

  factory MarketInstrumentListResponse.fromJson(Map<String, dynamic> data) =>
      MarketInstrumentListResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        MarketInstrumentList.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'MarketInstrumentListResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
