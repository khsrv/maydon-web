import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Универсальный делегат: объявляем поддержку кодов [supportedCodes],
/// а загружать просим локаль [fallback] у глобальных делегатов Flutter.
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate({
    required this.supportedCodes,
    required this.fallback,
  });

  final List<String> supportedCodes;
  final Locale fallback;

  @override
  bool isSupported(Locale locale) => supportedCodes.contains(locale.languageCode);

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return GlobalMaterialLocalizations.delegate.load(fallback);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate({
    required this.supportedCodes,
    required this.fallback,
  });

  final List<String> supportedCodes;
  final Locale fallback;

  @override
  bool isSupported(Locale locale) => supportedCodes.contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return GlobalCupertinoLocalizations.delegate.load(fallback);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
