import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class PortfolioResponse extends StdResponse<Portfolio> {
  PortfolioResponse(String trackingId, String status, Portfolio payload)
      : super(trackingId, status, payload);

  factory PortfolioResponse.fromJson(Map<String, dynamic> data) =>
      PortfolioResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        Portfolio.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'PortfolioResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
