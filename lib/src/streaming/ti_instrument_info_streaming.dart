import 'package:tinkoff_invest/src/models/event/streaming_instrument_info_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TIInstrumentInfoStreaming {
  /// Подписка на информацию об инструменте.
  void subscribe(
      String figi, void Function(StreamingInstrumentInfoEvent event) listener);

  /// Отписка от информации об инструменте.
  ///
  /// Если [listener] не указан, будут отписаны все слушатели.
  void unsubscribe(String figi,
      [void Function(StreamingInstrumentInfoEvent event)? listener]);
}

class TIInstrumentInfoStreamingImpl extends TIStreamingChannelImpl<
    StreamingInstrumentInfo,
    StreamingInstrumentInfoEvent> implements TIInstrumentInfoStreaming {
  TIInstrumentInfoStreamingImpl(WebSocketSink sink)
      : super('instrument_info', sink);

  @override
  void subscribe(
      String figi, void Function(StreamingInstrumentInfoEvent event) listener) {
    subscribeWith(
      {
        'figi': figi,
      },
      listener,
      (d) => d.figi == figi,
    );
  }

  @override
  void unsubscribe(String figi,
      [void Function(StreamingInstrumentInfoEvent event)? listener]) {
    unsubscribeWith(
      {
        'figi': figi,
      },
      listener,
    );
  }

  @override
  StreamingInstrumentInfoEvent fromMap(Map<String, dynamic> data) =>
      StreamingInstrumentInfoEvent.fromJson(data);
}
