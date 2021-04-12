import 'package:meta/meta.dart';

abstract class StreamingEvent<T> {
  final String event;
  final DateTime time;
  final T payload;

  StreamingEvent(this.event, this.time, this.payload);

  @protected
  String defaultToString(String className) => '$className(event: $event, '
      'time: $time, payload: $payload)';
}
