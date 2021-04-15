import 'dart:async';
import 'dart:convert';

import 'package:tinkoff_invest/src/streaming/ti_candle_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_orderbook_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming_channel.dart';
import 'package:web_socket_channel/io.dart';

/// Обертка для работы по протоколу streaming.
class TIStreaming {
  late IOWebSocketChannel _socket;
  late StreamSubscription _subscription;
  final bool _debug;

  final Set<TIStreamingChannel> _channels = {};

  TICandleStreamingImpl? _candle;
  TIOrderbookStreamingImpl? _orderbook;

  TIStreaming(String url, String token, {bool debug = false}) : _debug = debug {
    _socket = IOWebSocketChannel.connect(
      url,
      headers: <String, Object>{
        'Authorization': 'Bearer $token',
      },
    );

    _subscription = _socket.stream.listen(
      _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
  }

  /// Свечи.
  TICandleStreaming get candle =>
      _candle ??= _add(TICandleStreamingImpl(_socket.sink));

  /// Стакан.
  TIOrderbookStreaming get orderbook =>
      _orderbook ??= _add(TIOrderbookStreamingImpl(_socket.sink));

  void dispose() {
    _subscription.cancel();
    if (_socket.closeCode == null) _socket.sink.close();
  }

  void _onEvent(dynamic event) {
    if (_debug) _log('Event: $event');

    if (event is String && _channels.isNotEmpty) {
      final data = jsonDecode(event) as Map<String, dynamic>;
      _channels.forEach((channel) => channel.eventReceived(data));
    }
  }

  void _onError(Object error, StackTrace stack) {
    if (_debug) _log('Error: $error\nStack Trace:\n$stack');
  }

  void _onDone() {
    _log('Done');
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
