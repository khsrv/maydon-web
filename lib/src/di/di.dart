// path: lib/src/di/di.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:postj/features/onboarding/data/is_first_run_checker.dart';
import 'package:postj/features/onboarding/domain/services/first_run_checker.dart';
import 'package:postj/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:postj/features/version_check/data/repository/version_repository_impl.dart';
import 'package:postj/features/version_check/domain/repository/version_repository.dart';
import 'package:postj/features/version_check/presentation/cubit/version_check_cubit.dart';
import 'package:postj/features/video/data/repository/video_repository_impl.dart';
import 'package:postj/features/video/domain/repository/video_repository.dart';
import 'package:postj/features/video/presentation/cubit/videos_cubit.dart';
import 'package:postj/features/web_view/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/connectivity/connectivity_service.dart';
import '../core/network/dio_client.dart';
import '../core/notifications/notifier.dart';
import '../core/security/secure_storage.dart';
import '../core/telegram/telegram_service.dart';
import '../core/telegram/telegram_service_factory.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<AuthTokenStore>(
    () => AuthTokenStore(getIt<FlutterSecureStorage>()),
  );

  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(prefs);

  // Connectivity
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(getIt<Connectivity>()),
  );

  // Notifier
  getIt.registerLazySingleton<Notifier>(() => Notifier());

  // Dio client
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      tokenStore: getIt<AuthTokenStore>(),
      connectivityService: getIt<ConnectivityService>(),
      notifier: getIt<Notifier>(),
    ),
  );

  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit());

  getIt.registerLazySingleton<FirstRunChecker>(() => IsFirstRunChecker());
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit(getIt()));

  // Firebase Firestore
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Video
  getIt.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory<VideosCubit>(() => VideosCubit(getIt()));

  // Version Check
  getIt.registerLazySingleton<VersionRepository>(
    () => VersionRepositoryImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory<VersionCheckCubit>(() => VersionCheckCubit(getIt()));

  // Telegram Web App Service
  getIt.registerLazySingleton<TelegramService>(
    () => createTelegramService(),
  );
}
