
// path: lib/src/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:postj/src/core/connectivity/connectivity_service.dart';
import '../notifications/notifier.dart';
import '../security/secure_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class DioClient {
  DioClient({
    required AuthTokenStore tokenStore,
    required ConnectivityService connectivityService,
    required Notifier notifier,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.example.com'),
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
            responseType: ResponseType.json,
            contentType: 'application/json',
          ),
        ) {
    dio.interceptors.addAll([
      AuthInterceptor(tokenStore: tokenStore),
      RetryInterceptor(dio: dio, connectivityService: connectivityService),
      LoggingInterceptor(),
    ]);
  }

  final Dio dio;
}
