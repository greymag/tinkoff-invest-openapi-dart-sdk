import 'package:tinkoff_invest/src/models/event/streaming_orderbook_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';

import 'ti_streaming.dart';

abstract class TIOrderbookStreaming {
  /// Подписка на стакан.
  ///
  /// [depth] определяет глубину стакана.
  /// Может принимать значения от 0 до 20 включая: `0 < depth <= 20`.
  ///
  /// Можно указать произвольный [requestId], который будет использован
  /// в сообщении об ошибке, если она произойдет.
  void subscribe(String figi, int depth,
      void Function(StreamingOrderbookEvent event) listener,
      [String? requestId]);

  /// Отписка от стакана.
  ///
  /// Если [listener] не указан, будут отписаны все слушатели.
  ///
  /// [depth] определяет глубину стакана.
  /// Может принимать значения от 0 до 20 включая: `0 < depth <= 20`.
  ///
  /// Можно указать произвольный [requestId], который будет использован
  /// в сообщении об ошибке, если она произойдет.
  void unsubscribe(String figi, int depth,
      [void Function(StreamingOrderbookEvent event)? listener,
      String? requestId]);
}

class TIOrderbookStreamingImpl
    extends TIStreamingChannelImpl<StreamingOrderbook, StreamingOrderbookEvent>
    implements TIOrderbookStreaming {
  TIOrderbookStreamingImpl(TIStreamingConnection connection)
      : super('orderbook', connection);

  @override
  void subscribe(String figi, int depth,
      void Function(StreamingOrderbookEvent event) listener,
      [String? requestId]) {
    assert(depth > 0 && depth <= 20);
    subscribeWith(
      {
        'figi': figi,
        'depth': depth,
      },
      listener,
      (d) => d.figi == figi && d.depth == depth,
      requestId,
    );
  }

  @override
  void unsubscribe(String figi, int depth,
      [void Function(StreamingOrderbookEvent event)? listener,
      String? requestId]) {
    assert(depth > 0 && depth <= 20);
    unsubscribeWith(
      {
        'figi': figi,
        'depth': depth,
      },
      listener,
      requestId,
    );
  }

  @override
  StreamingOrderbookEvent fromMap(Map<String, dynamic> data) =>
      StreamingOrderbookEvent.fromJson(data);
}
