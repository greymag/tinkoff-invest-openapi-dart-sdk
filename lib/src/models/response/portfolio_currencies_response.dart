import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class PortfolioCurrenciesResponse extends StdResponse<Currencies> {
  PortfolioCurrenciesResponse(
      String trackingId, String status, Currencies payload)
      : super(trackingId, status, payload);

  factory PortfolioCurrenciesResponse.fromJson(Map<String, dynamic> data) =>
      PortfolioCurrenciesResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        Currencies.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'PortfolioCurrenciesResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
