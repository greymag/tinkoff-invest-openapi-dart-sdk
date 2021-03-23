import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tinkoff_invest/src/models/response/error_response.dart';

abstract class TIEndpoint {
  @protected
  final Dio dio;

  @protected
  final String endpoint;

  TIEndpoint(this.dio, this.endpoint);

  /// Makes GET request and returns parsed result.
  ///
  /// If result can't be parsed then [ErrorResult] will be returned.
  /// If request fails then [ErrorResult] with [DioError] will be returned.
  /// If request got error responses then [ErrorResult] with [ErrorResponse]
  /// will be returned.
  @protected
  Future<Result<T>> get<T>(T Function(Map<String, dynamic> data) fromMap,
      [Map<String, dynamic>? params]) async {
    return _request(
      (path) => dio.get(path, queryParameters: params),
      fromMap,
    );
  }

  Future<Result<T>> _request<T>(
      Future<Response<Map<String, dynamic>>> Function(String path) perform,
      T Function(Map<String, dynamic> data) fromMap) async {
    final path = endpoint;
    try {
      final response = await perform(path);

      final data = response.data;
      if (data != null) {
        final res = fromMap(data);
        return Result.value(res);
      } else {
        return Result.error('Failed to parse response');
      }
    } on DioError catch (e) {
      final Object? errorResponse = e.response?.data;
      if (errorResponse != null && errorResponse is Map<String, dynamic>) {
        final parsed = ErrorResponse.fromJson(errorResponse);
        return Result.error(parsed);
      } else {
        return Result.error('Failed to parse response');
      }
    }
  }
}
