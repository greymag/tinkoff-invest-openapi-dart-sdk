import 'package:tinkoff_invest/src/models/from_json.dart';
import 'package:tinkoff_invest/src/models/event/streaming_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming_candle.dart';

class StreamingCandleEvent extends StreamingEvent<StreamingCandle> {
  StreamingCandleEvent(String event, DateTime time, StreamingCandle payload)
      : super(event, time, payload);

  factory StreamingCandleEvent.fromJson(Map<String, dynamic> data) =>
      StreamingCandleEvent(
        data['event'] as String,
        data.requireDateTime('time'),
        StreamingCandle.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => defaultToString('StreamingCandleEvent');
}
