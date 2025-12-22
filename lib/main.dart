// path: lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postj/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:postj/features/version_check/presentation/cubit/version_check_cubit.dart';
import 'package:postj/features/web_view/presentation/cubit/locale_cubit.dart';
import 'package:postj/firebase_option.dart';
import 'package:postj/src/routing/app_router.dart';
import 'src/app.dart';
import 'src/di/di.dart';
import 'src/core/telegram/telegram_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();

  // Инициализация Telegram Web App (только на веб-платформе)
  final telegramService = getIt<TelegramService>();
  if (telegramService.isAvailable) {
    telegramService.init();
    // Настройка цветов под тему Telegram
    telegramService.setBackgroundColor('#FFFFFF');
    telegramService.expand();
  }

  final onboardingCubit = getIt<OnboardingCubit>();
  await onboardingCubit.init();

  final versionCheckCubit = getIt<VersionCheckCubit>();
  await versionCheckCubit.checkVersion();

  final router = createRouter(onboardingCubit, versionCheckCubit);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LocaleCubit>()),
        BlocProvider.value(value: versionCheckCubit),
      ],
      child: App(goRouter: router),
    ),
  );
}
