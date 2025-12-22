
// path: lib/src/core/network/interceptors/retry_interceptor.dart
import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import '../../connectivity/connectivity_service.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.connectivityService,
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 300),
  });

  final Dio dio;
  final ConnectivityService connectivityService;
  final int maxRetries;
  final Duration baseDelay;

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }
    final status = err.response?.statusCode ?? 0;
    return status >= 500 && status < 600;
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    var attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;

    if (!_shouldRetry(err) || attempt >= maxRetries) {
      return handler.next(err);
    }

    if (!await connectivityService.isOnline) {
      await connectivityService.onStatusChanged.firstWhere((online) => online);
    }

    final backoffMs = baseDelay.inMilliseconds * pow(2, attempt);
    final jitter = Random().nextInt(150);
    await Future.delayed(Duration(milliseconds: backoffMs.toInt() + jitter));

    final opts = err.requestOptions;
    final newOptions = Options(
      method: opts.method,
      headers: Map<String, dynamic>.from(opts.headers),
      responseType: opts.responseType,
      contentType: opts.contentType,
      followRedirects: opts.followRedirects,
      listFormat: opts.listFormat,
      receiveDataWhenStatusError: opts.receiveDataWhenStatusError,
      receiveTimeout: opts.receiveTimeout,
      sendTimeout: opts.sendTimeout,
      validateStatus: opts.validateStatus,
      extra: Map.of(opts.extra)..['retry_attempt'] = attempt + 1,
    );

    try {
      final response = await dio.request<dynamic>(
        opts.path,
        data: opts.data,
        queryParameters: opts.queryParameters,
        cancelToken: opts.cancelToken,
        onReceiveProgress: opts.onReceiveProgress,
        onSendProgress: opts.onSendProgress,
        options: newOptions,
      );
      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }
}
