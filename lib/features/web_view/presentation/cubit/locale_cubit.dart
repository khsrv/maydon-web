import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postj/src/core/extensions/prefs_extensions.dart';
import 'package:postj/src/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(const Locale('tg')) {
    final savedLocale = getIt<SharedPreferences>().readLocal();
    emit(savedLocale ?? const Locale('tg'));
  }

  Future<void> setLocale(Locale locale) async {
    await getIt<SharedPreferences>().writeLocal(locale);
    emit(locale);
  }
}
