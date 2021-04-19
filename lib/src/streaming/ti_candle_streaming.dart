import 'package:tinkoff_invest/src/models/event/streaming_candle_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TICandleStreaming {
  /// Подписка на свечи.
  void subscribe(String figi, StreamingCandleInterval interval,
      void Function(StreamingCandleEvent event) listener);

  /// Отписка от свечей.
  ///
  /// Если [listener] не указан, будут отписаны все слушатели.
  void unsubscribe(String figi, StreamingCandleInterval interval,
      [void Function(StreamingCandleEvent event)? listener]);
}

class TICandleStreamingImpl
    extends TIStreamingChannelImpl<StreamingCandle, StreamingCandleEvent>
    implements TICandleStreaming {
  TICandleStreamingImpl(WebSocketSink sink) : super('candle', sink);

  @override
  void subscribe(String figi, StreamingCandleInterval interval,
      void Function(StreamingCandleEvent event) listener) {
    subscribeWith(
      {
        'figi': figi,
        'interval': interval.toJson(),
      },
      listener,
      (d) => d.figi == figi && d.interval == interval,
    );
  }

  @override
  void unsubscribe(String figi, StreamingCandleInterval interval,
      [void Function(StreamingCandleEvent event)? listener]) {
    unsubscribeWith(
      {
        'figi': figi,
        'interval': interval.toJson(),
      },
      listener,
    );
  }

  @override
  StreamingCandleEvent fromMap(Map<String, dynamic> data) =>
      StreamingCandleEvent.fromJson(data);
}