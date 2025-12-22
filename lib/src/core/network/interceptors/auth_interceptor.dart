
// path: lib/src/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../security/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStore});
  final AuthTokenStore tokenStore;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStore.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await tokenStore.clearTokens();
    }
    handler.next(err);
  }
}
