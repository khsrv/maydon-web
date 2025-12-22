import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Подменяем системные Material-строки для 'tg' русскими
class TgMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const TgMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // Используем русскую локализацию как fallback для таджикского
    return GlobalMaterialLocalizations.delegate.load(const Locale('ru'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}

// Подменяем системные Widgets-строки для 'tg' русскими
class TgWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const TgWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    // Используем русскую локализацию как fallback для таджикского
    return GlobalWidgetsLocalizations.delegate.load(const Locale('ru'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<WidgetsLocalizations> old) => false;
}

// Подменяем системные Cupertino-строки для 'tg' русскими
class TgCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const TgCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tg';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    // Используем русскую локализацию как fallback для таджикского
    return GlobalCupertinoLocalizations.delegate.load(const Locale('ru'));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}
