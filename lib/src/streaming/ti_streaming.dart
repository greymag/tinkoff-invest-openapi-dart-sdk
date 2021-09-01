import 'dart:async';
import 'dart:convert';

import 'package:tinkoff_invest/src/models/event/streaming_error_event.dart';
import 'package:tinkoff_invest/src/streaming/ti_candle_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_instrument_info_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_orderbook_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Обертка для работы по протоколу streaming.
abstract class TIStreaming {
  /// Свечи.
  TICandleStreaming get candle;

  /// Стакан.
  TIOrderbookStreaming get orderbook;

  /// Информация об инструменте.
  TIInstrumentInfoStreaming get instrumentInfo;

  /// Устанавливает обработчик ошибок.
  ///
  /// [listener] вызовется, если от сервиса пришла ошибка.
  /// Ошибка может приходить например в случае,
  /// если попытались подписаться на несуществующий инструмент
  /// (передали некорректный FIGI).
  /// См. https://tinkoffcreditsystems.github.io/invest-openapi/marketdata/#_3
  ///
  /// Если обработчик уже был установлен - он будут перезаписать.
  ///
  /// Если вы хотите сбросить обработчик - просто передайте `null`.
  void onError(void Function(StreamingErrorEvent event)? listener);
}

abstract class TIStreamingConnection {
  void send(String data);
}

class TIStreamingImpl implements TIStreaming, TIStreamingConnection {
  static const _eventNameField = 'event';
  static const _errorEventName = 'error';

  late IOWebSocketChannel _socket;
  late StreamSubscription _subscription;
  final bool _debug;

  final Set<TIStreamingChannel> _channels = {};

  TICandleStreamingImpl? _candle;
  TIOrderbookStreamingImpl? _orderbook;
  TIInstrumentInfoStreamingImpl? _instrumentInfo;

  void Function(StreamingErrorEvent event)? _errorListener;

  TIStreamingImpl(String url, String token, {bool debug = false})
      : _debug = debug {
    _socket = IOWebSocketChannel.connect(
      url,
      headers: <String, Object>{
        'Authorization': 'Bearer $token',
      },
      pingInterval: const Duration(minutes: 2),
    );

    _subscription = _socket.stream.listen(
      _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
  }

  @override
  TICandleStreaming get candle => _candle ??= _add(TICandleStreamingImpl(this));

  @override
  TIOrderbookStreaming get orderbook =>
      _orderbook ??= _add(TIOrderbookStreamingImpl(this));

  @override
  TIInstrumentInfoStreaming get instrumentInfo =>
      _instrumentInfo ??= _add(TIInstrumentInfoStreamingImpl(this));

  void dispose() {
    _subscription.cancel();
    if (_socket.closeCode == null) _socket.sink.close();
  }

  @override
  void onError(void Function(StreamingErrorEvent event)? listener) {
    _errorListener = listener;
  }

  @override
  void send(String data) {
    if (_debug) _log('Send: $data');
    _socket.sink.add(data);
  }

  void _onEvent(dynamic event) {
    if (_debug) _log('Event: $event');

    if (event is String) {
      final data = jsonDecode(event) as Map<String, dynamic>;
      final eventName = data[_eventNameField] as String?;
      if (eventName == _errorEventName) {
        final listener = _errorListener;
        if (listener != null) {
          listener(StreamingErrorEvent.fromJson(data));
        }
      } else if (eventName != null) {
        _channels.forEach((channel) => channel.eventReceived(eventName, data));
      } else {
        assert(false, 'Event name is not defined. Received: $event');
      }
    }
  }

  void _onError(Object error, StackTrace stack) {
    if (_debug) _log('Error: $error\nStack Trace:\n$stack');
  }

  void _onDone() {
    _log('Done');
    if (_debug && _socket.closeReason != null) {
      _log('Reason: ${_socket.closeReason} [${_socket.closeCode}]');
    }
  }

  void _log(String message) {
    if (_debug) {
      // ignore: avoid_print
      print('[streaming] $message');
    }
  }

  T _add<T extends TIStreamingChannel>(T channel) {
    _channels.add(channel);
    return channel;
  }
}
