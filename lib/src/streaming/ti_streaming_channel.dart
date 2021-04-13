import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:tinkoff_invest/src/models/event/streaming_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef EventFilter<T> = bool Function(T payload);

abstract class TIStreamingChannel {
  void eventReceived(Map<String, dynamic> data);
}

abstract class TIStreamingChannelImpl<T, E extends StreamingEvent<T>>
    implements TIStreamingChannel {
  static const _eventNameField = 'event';
  static const _subscribeEvent = 'subscribe';
  static const _unsubscribeEvent = 'unsubscribe';

  @protected
  final WebSocketSink sink;

  @protected
  final String name;

  final Map<String, Set<Function>> _listeners = {};
  final Map<String, Map<EventFilter<T>, Function>> _filters2Listeners = {};

  TIStreamingChannelImpl(this.name, this.sink);

  @override
  void eventReceived(Map<String, dynamic> data) {
    if (data[_eventNameField] == name) {
      final event = fromMap(data);
      final payload = event.payload;
      _filters2Listeners.forEach((key, map) {
        map.forEach((filter, listener) {
          if (filter(payload)) {
            listener(event);
          }
        });
      });
    }
  }

  @protected
  E fromMap(Map<String, dynamic> data);

  @protected
  void subscribeWith(
    Map<String, Object> params,
    void Function(E event) listener,
    EventFilter<T> filter,
  ) {
    final key = _getKey(params);
    final listeners = _listeners[key] ??= {};

    final needSubscription = listeners.isEmpty;
    if (listeners.add(listener)) {
      if (_filters2Listeners.containsKey(key)) {
        _filters2Listeners[key]![filter] = listener;
      } else {
        _filters2Listeners[key] = {filter: listener};
      }

      if (needSubscription) {
        sendEvent(_subscribeEvent, params);
      }
    }
  }

  @protected
  void unsubscribeWith(
    Map<String, Object> params,
    void Function(E event)? listener,
  ) {
    final key = _getKey(params);
    final listeners = _listeners[key];

    if (listeners != null && listeners.isNotEmpty) {
      if (listener != null) {
        if (listeners.remove(listener)) {
          _filters2Listeners[key]
              ?.removeWhere((key, value) => value == listener);
        }
      } else {
        listeners.clear();
        _filters2Listeners.remove(key);
      }

      if (listeners.isEmpty) {
        sendEvent(_unsubscribeEvent, params);
      }
    }
  }

  @protected
  void sendEvent(String event, Map<String, Object> data) {
    send({
      'event': '$name:$event',
    }..addAll(data));
  }

  @protected
  void send(Map<String, Object> data) {
    final json = jsonEncode(data);
    sink.add(json);
  }

  String _getKey(Map<String, Object> params) => jsonEncode(params);
}
