
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('--> ${options.method} ${options.uri}');
    if (options.data != null) {
      // ignore: avoid_print
      print('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('<-- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('xx> ${err.requestOptions.uri}  ERROR: ${err.message}');
    handler.next(err);
  }
}
