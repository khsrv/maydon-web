import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const localeCode = 'app_locale_code'; // 'ru' | 'en' | 'tg' | null

extension LocalPrefsX on SharedPreferences {
  Locale? readLocal() {
    final code = getString(localeCode);
    return (code == null || code.isEmpty) ? null : Locale(code);
  }

  Future<bool> writeLocal(Locale? local) async {
    return local == null
        ? remove(localeCode)
        : setString(localeCode, local.languageCode);
  }
}
