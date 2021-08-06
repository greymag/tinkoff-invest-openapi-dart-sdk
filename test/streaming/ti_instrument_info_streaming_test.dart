import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:test/scaffolding.dart';
import 'package:tinkoff_invest/src/streaming/ti_instrument_info_streaming.dart';
import 'package:tinkoff_invest/src/streaming/ti_streaming.dart';

void main() {
  group('TIInstrumentInfoStreamingImpl', () {
    group('eventReceived', () {
      test('should parse event date without exception', () {
        final streaming =
            TIInstrumentInfoStreamingImpl(_StreamingConnectionMock());

        streaming.eventReceived(
            'instrument_info',
            jsonDecode(
                    '{"payload":{"figi":"BBG004730N88","trade_status":"opening_auction","min_price_increment":0.01,"lot":10},"event":"instrument_info","time":"2021-08-06T16:00:03.178466459Z"}')
                as Map<String, dynamic>);
      });
    });
  });
}

class _StreamingConnectionMock extends Mock implements TIStreamingConnection {}
