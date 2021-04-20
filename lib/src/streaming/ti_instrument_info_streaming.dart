import 'package:tinkoff_invest/src/models/event/streaming_instrument_info_event.dart';
import 'package:tinkoff_invest/src/models/streaming/streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';

import 'ti_streaming.dart';

abstract class TIInstrumentInfoStreaming {
  /// Подписка на информацию об инструменте.
  ///
  /// Можно указать произвольный [requestId], который будет использован
  /// в сообщении об ошибке, если она произойдет.
  void subscribe(
      String figi, void Function(StreamingInstrumentInfoEvent event) listener,
      [String? requestId]);

  /// Отписка от информации об инструменте.
  ///
  /// Если [listener] не указан, будут отписаны все слушатели.
  ///
  /// Можно указать произвольный [requestId], который будет использован
  /// в сообщении об ошибке, если она произойдет.
  void unsubscribe(String figi,
      [void Function(StreamingInstrumentInfoEvent event)? listener,
      String? requestId]);
}

class TIInstrumentInfoStreamingImpl extends TIStreamingChannelImpl<
    StreamingInstrumentInfo,
    StreamingInstrumentInfoEvent> implements TIInstrumentInfoStreaming {
  TIInstrumentInfoStreamingImpl(TIStreamingConnection connection)
      : super('instrument_info', connection);

  @override
  void subscribe(
      String figi, void Function(StreamingInstrumentInfoEvent event) listener,
      [String? requestId]) {
    subscribeWith(
      {
        'figi': figi,
      },
      listener,
      (d) => d.figi == figi,
      requestId,
    );
  }

  @override
  void unsubscribe(String figi,
      [void Function(StreamingInstrumentInfoEvent event)? listener,
      String? requestId]) {
    unsubscribeWith(
      {
        'figi': figi,
      },
      listener,
      requestId,
    );
  }

  @override
  StreamingInstrumentInfoEvent fromMap(Map<String, dynamic> data) =>
      StreamingInstrumentInfoEvent.fromJson(data);
}
