import 'package:tinkoff_invest/src/models/from_json.dart';
import 'package:tinkoff_invest/src/models/event/streaming_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';

class StreamingOrderbookEvent extends StreamingEvent<StreamingOrderbook> {
  StreamingOrderbookEvent(
      String event, DateTime time, StreamingOrderbook payload)
      : super(event, time, payload);

  factory StreamingOrderbookEvent.fromJson(Map<String, dynamic> data) =>
      StreamingOrderbookEvent(
        data['event'] as String,
        data.requireDateTime('time'),
        StreamingOrderbook.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => defaultToString('StreamingOrderbookEvent');
}
