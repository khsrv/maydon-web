abstract class FirstRunChecker {
  /// true — самое первое открытие приложения (после установки).
  /// false — не первый запуск.
  Future<bool> isFirstRun();
}
