import 'package:tinkoff_invest/src/models/from_json.dart';
import 'package:tinkoff_invest/src/models/event/streaming_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';

class StreamingInstrumentInfoEvent
    extends StreamingEvent<StreamingInstrumentInfo> {
  StreamingInstrumentInfoEvent(
      String event, DateTime time, StreamingInstrumentInfo payload)
      : super(event, time, payload);

  factory StreamingInstrumentInfoEvent.fromJson(Map<String, dynamic> data) =>
      StreamingInstrumentInfoEvent(
        data['event'] as String,
        data.requireDateTime('time'),
        StreamingInstrumentInfo.fromJson(
            data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => defaultToString('StreamingInstrumentInfoEvent');
}
