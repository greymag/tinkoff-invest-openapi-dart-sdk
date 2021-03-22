import 'package:tinkoff_invest/src/models/data/data.dart';

class PortfolioResponse {
  final String trackingId;
  final String status;
  final Portfolio payload;

  PortfolioResponse(this.trackingId, this.status, this.payload);

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
