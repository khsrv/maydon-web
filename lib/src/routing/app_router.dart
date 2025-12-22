// path: lib/src/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:postj/features/calendar/presentation/pages/calendar_page.dart';
import 'package:postj/features/home/presentation/pages/home_page.dart';
import 'package:postj/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:postj/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:postj/features/onboarding/presentation/screen/splash_screen.dart';
import 'package:postj/features/privacy/presentation/pages/privacy_page.dart';
import 'package:postj/features/profile/presentation/pages/profile_page.dart';
import 'package:postj/features/rules/presentation/pages/rules_page.dart';
import 'package:postj/features/scorers/presentation/pages/scorers_page.dart';
import 'package:postj/features/version_check/presentation/cubit/version_check_cubit.dart';
import 'package:postj/features/version_check/presentation/pages/force_update_page.dart';
import 'package:postj/features/video/presentation/cubit/videos_cubit.dart';
import 'package:postj/features/video/presentation/pages/video_page.dart';
import 'package:postj/features/web_view/presentation/pages/web_view_widget.dart';
import 'package:postj/l10n/app_localizations.dart';

import 'go_router_refresh.dart'; // должен содержать GoRouterMultiRefresh из примера ниже
import '../core/notifications/notifier.dart';
import '../di/di.dart';
import '../theme/app_theme.dart';
import 'keys.dart';

GoRouter createRouter(
  OnboardingCubit onboardingCubit,
  VersionCheckCubit versionCheckCubit,
) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: GoRouterMultiRefresh([
      onboardingCubit.stream, // слушаем, чтобы дергать redirect
      versionCheckCubit.stream, // слушаем изменения версии
    ]),
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      // Экран принудительного обновления
      GoRoute(
        path: '/force-update',
        name: 'force-update',
        builder: (context, state) => const ForceUpdatePage(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => BlocProvider.value(
          value: onboardingCubit, // тот же инстанс, что в main()
          child: const OnboardingPage(),
        ),
      ),

      // Нижняя навигация с 4 экранами
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          getIt<Notifier>().attach(rootNavigatorKey);
          return _AppShell(navigationShell: navigationShell);
        },
        branches: [
          // Главная
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          // Календарь матчей
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                name: 'calendar',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalendarPage(),
                ),
              ),
            ],
          ),
          // Нишонзанхо
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scorers',
                name: 'scorers',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ScorersPage(),
                ),
              ),
            ],
          ),
          // Профиль
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
      // WebView с параметром URL
      GoRoute(
        path: '/webview',
        name: 'webview',
        builder: (context, state) {
          final url = state.uri.queryParameters['url'];
          final title = state.uri.queryParameters['title'];
          if (url == null || url.isEmpty) {
            return const Scaffold(body: Center(child: Text('URL не указан')));
          }
          // GoRouter автоматически декодирует query параметры
          return WebViewPage(url: url, title: title);
        },
      ),
      // Видео
      GoRoute(
        path: '/video',
        name: 'video',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<VideosCubit>(),
          child: const VideoPage(),
        ),
      ),
      // Правила
      GoRoute(
        path: '/rules',
        name: 'rules',
        builder: (context, state) => const RulesPage(),
      ),
      // Политика конфиденциальности
      GoRoute(
        path: '/privacy',
        name: 'privacy',
        builder: (context, state) => const PrivacyPage(),
      ),
    ],

    // 🔥 redirect ДОЛЖЕН быть на корневом GoRouter, а не на ShellRoute
    redirect: (context, state) {
      const splash = '/splash';
      const onboarding = '/onboarding';
      // const onboarding = '/';
      const home = '/';
      const forceUpdate = '/force-update';

      final loc = state.matchedLocation;
      final ob = onboardingCubit.state;
      final vc = versionCheckCubit.state;

      // 0) ПРИОРИТЕТ: Проверка версии - если требуется обновление, блокируем всё
      if (vc is VersionCheckUpdateRequired) {
        return (loc == forceUpdate) ? null : forceUpdate;
      }

      // Если версия проверяется, ждём на splash
      if (vc is VersionCheckLoading) {
        return (loc == splash) ? null : splash;
      }

      // 1) Пока грузится — держим на splash
      final isLoading = ob.maybeWhen(loading: () => true, orElse: () => false);
      if (isLoading) return (loc == splash) ? null : splash;

      // 2) Если нужно показать онбординг — держим строго на /onboarding
      final need = ob.maybeWhen(needs: () => true, orElse: () => false);
      if (need) return (loc == onboarding) ? null : onboarding;

      // 3) Онбординг завершён/не нужен — отправляем домой, если мы всё ещё на splash/onboarding
      if (loc == splash || loc == onboarding) return home;

      return null; // остаёмся где есть
    },
  );
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: kWebViewHeaderBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          backgroundColor: kWebViewHeaderBlue,
          selectedItemColor: kWhite,
          unselectedItemColor: Colors.white70,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: l10n.navHome,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today_outlined),
              activeIcon: const Icon(Icons.calendar_today),
              label: l10n.navCalendar,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.sports_soccer_outlined),
              activeIcon: const Icon(Icons.sports_soccer),
              label: l10n.scorers,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: l10n.navSupport,
            ),
          ],
        ),
      ),
    );
  }
}
