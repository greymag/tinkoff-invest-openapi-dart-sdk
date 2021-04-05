import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class SearchMarketInstrumentResponse
    extends StdResponse<SearchMarketInstrument> {
  SearchMarketInstrumentResponse(
      String trackingId, String status, SearchMarketInstrument payload)
      : super(trackingId, status, payload);

  factory SearchMarketInstrumentResponse.fromJson(Map<String, dynamic> data) =>
      SearchMarketInstrumentResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        SearchMarketInstrument.fromJson(
            data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() =>
      'SearchMarketInstrumentResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
