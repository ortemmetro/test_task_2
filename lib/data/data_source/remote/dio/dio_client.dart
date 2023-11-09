import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<T> response = await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      if (e is DioException) {
        rethrow;
      } else {
        throw Exception();
      }
    }
  }
}
