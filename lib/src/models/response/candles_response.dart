import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class CandlesResponse extends StdResponse<Candles> {
  CandlesResponse(String trackingId, String status, Candles payload)
      : super(trackingId, status, payload);

  factory CandlesResponse.fromJson(Map<String, dynamic> data) =>
      CandlesResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        Candles.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'CandlesResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
