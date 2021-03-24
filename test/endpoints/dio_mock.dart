import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

Dio dioFor(String response, int statusCode) =>
    dioWith(HttpClientAdapterMock(response, statusCode));

Dio dioForSuccess(String response) => dioFor(response, 200);

Dio dioForError(String response, [int statusCode = 500]) =>
    dioFor(response, statusCode);

Dio dioWith(HttpClientAdapterMock adapter) =>
    Dio()..httpClientAdapter = adapter;

class HttpClientAdapterMock extends Mock implements HttpClientAdapter {
  final String response;
  final int statusCode;

  HttpClientAdapterMock(this.response, this.statusCode);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future? cancelFuture,
  ) {
    return Future.value(ResponseBody.fromString(
      response,
      statusCode,
      headers: {
        'content-type': ['application/json; charset=utf-8']
      },
    ));
  }
}
