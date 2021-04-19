import 'package:tinkoff_invest/src/models/event/streaming_orderbook_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class TIOrderbookStreaming {
  /// Подписка на стакан.
  void subscribe(String figi, int depth,
      void Function(StreamingOrderbookEvent event) listener);

  /// Отписка от стакана.
  ///
  /// Если [listener] не указан, будут отписаны все слушатели.
  ///
  /// [depth] определяет глубину стакана.
  /// Может принимать значения от 0 до 20 включая: `0 < depth <= 20`.
  void unsubscribe(String figi, int depth,
      [void Function(StreamingOrderbookEvent event)? listener]);
}

class TIOrderbookStreamingImpl
    extends TIStreamingChannelImpl<StreamingOrderbook, StreamingOrderbookEvent>
    implements TIOrderbookStreaming {
  TIOrderbookStreamingImpl(WebSocketSink sink) : super('orderbook', sink);

  @override
  void subscribe(String figi, int depth,
      void Function(StreamingOrderbookEvent event) listener) {
    assert(depth > 0 && depth <= 20);
    subscribeWith(
      {
        'figi': figi,
        'depth': depth,
      },
      listener,
      (d) => d.figi == figi && d.depth == depth,
    );
  }

  @override
  void unsubscribe(String figi, int depth,
      [void Function(StreamingOrderbookEvent event)? listener]) {
    unsubscribeWith(
      {
        'figi': figi,
        'depth': depth,
      },
      listener,
    );
  }

  @override
  StreamingOrderbookEvent fromMap(Map<String, dynamic> data) =>
      StreamingOrderbookEvent.fromJson(data);
}
