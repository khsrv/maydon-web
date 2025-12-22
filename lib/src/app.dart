// path: lib/src/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:postj/features/web_view/presentation/cubit/locale_cubit.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/l10n/tg_fallback_localizations.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.goRouter});
  final GoRouter goRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale?>(
      builder: (context, locale) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
          title: 'Clean App',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: ThemeMode.dark,
          locale: locale ?? const Locale('tg'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            TgMaterialLocalizationsDelegate(),
            TgWidgetsLocalizationsDelegate(),
            TgCupertinoLocalizationsDelegate(),
          ],
        );
      },
    );
  }
}
