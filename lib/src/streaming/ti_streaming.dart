import 'dart:async';

import 'package:web_socket_channel/io.dart';

/// Обертка для работы по протоколу streaming.
class TIStreaming {
  late IOWebSocketChannel _channel;
  late StreamSubscription _subscription;
  final bool _debug;

  TIStreaming(String url, String token, {bool debug = false}) : _debug = debug {
    _channel = IOWebSocketChannel.connect(
      url,
      headers: <String, Object>{
        'Authorization': 'Bearer $token',
      },
    );

    _subscription = _channel.stream.listen(
      _onEvent,
      onError: _onError,
      onDone: _onDone,
    );
  }

  void dispose() {
    _subscription.cancel();
    if (_channel.closeCode == null) _channel.sink.close();
  }

  void _onEvent(dynamic event) {
    if (_debug) _log('Event: $event');
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
}
