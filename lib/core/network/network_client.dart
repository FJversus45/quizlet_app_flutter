import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';

class NetworkClient {
  NetworkClient({required Dio dio, required LocalCache cache})
    : _dio = dio,
      _cache = cache {
    _setupInterceptors();
  }

  final Dio _dio;
  final LocalCache _cache;
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (
              RequestOptions requestOptions,
              RequestInterceptorHandler handler,
            ) async {
              final token = await _cache.getToken();

              if (token.isNotEmpty) {
                requestOptions.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(requestOptions);
            },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          if (e.response?.statusCode == 401) {
            // Logout the user since the token is unauthorized
          }
          return handler.next(e);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (text) {
            // 800 is the sie of each chunk
            final pattern = RegExp('.{1,800}');
            pattern
                .allMatches(text.toString())
                .forEach((match) => debugPrint(match.group(0)));
          },
        ),
      );
    }
  }

  Future<Response<Map<String, dynamic>?>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<Map<String, dynamic>?>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<Map<String, dynamic>?>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<Map<String, dynamic>>> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
