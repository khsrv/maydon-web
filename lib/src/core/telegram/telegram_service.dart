// path: lib/src/core/telegram/telegram_service.dart
import 'package:flutter/foundation.dart';

// Условный импорт для веб-платформы
import 'telegram_web_app_service.dart' 
    if (dart.library.io) 'telegram_web_app_service_stub.dart';

/// Абстракция для работы с Telegram Web App API
/// Работает только на веб-платформе
abstract class TelegramService {
  /// Проверить доступность Telegram Web App API
  bool get isAvailable;

  /// Инициализация Telegram Web App
  void init();

  /// Получить данные пользователя
  Map<String, dynamic>? getUserData();

  /// Получить тему Telegram
  String? getTheme();

  /// Получить параметры запуска
  Map<String, String>? getStartParam();

  /// Показать главную кнопку
  void showMainButton({required String text, required VoidCallback onTap});

  /// Скрыть главную кнопку
  void hideMainButton();

  /// Показать алерт
  void showAlert(String message);

  /// Показать подтверждение
  Future<bool> showConfirm(String message);

  /// Установить цвет фона
  void setBackgroundColor(String color);

  /// Установить цвет заголовка
  void setHeaderColor(String color);

  /// Закрыть приложение
  void close();

  /// Отправить данные в бота
  void sendData(String data);

  /// Расширить приложение на весь экран
  void expand();
}

/// Реализация для веб-платформы
class TelegramServiceImpl implements TelegramService {
  // Используем условный импорт
  // ignore: avoid_web_libraries_in_flutter
  final TelegramWebAppService? _webAppService;

  TelegramServiceImpl() : _webAppService = _createWebAppService();

  static TelegramWebAppService? _createWebAppService() {
    if (kIsWeb) {
      try {
        // ignore: avoid_web_libraries_in_flutter
        return TelegramWebAppService();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  bool get isAvailable {
    if (!kIsWeb || _webAppService == null) return false;
    // isAvailable - это статический геттер
    return TelegramWebAppService.isAvailable;
  }

  @override
  void init() => _webAppService?.init();

  @override
  Map<String, dynamic>? getUserData() => _webAppService?.getUserData();

  @override
  String? getTheme() => _webAppService?.getTheme();

  @override
  Map<String, String>? getStartParam() => _webAppService?.getStartParam();

  @override
  void showMainButton({required String text, required VoidCallback onTap}) {
    _webAppService?.showMainButton(text: text, onTap: onTap);
  }

  @override
  void hideMainButton() => _webAppService?.hideMainButton();

  @override
  void showAlert(String message) => _webAppService?.showAlert(message);

  @override
  Future<bool> showConfirm(String message) => 
      _webAppService?.showConfirm(message) ?? Future.value(false);

  @override
  void setBackgroundColor(String color) => _webAppService?.setBackgroundColor(color);

  @override
  void setHeaderColor(String color) => _webAppService?.setHeaderColor(color);

  @override
  void close() => _webAppService?.close();

  @override
  void sendData(String data) => _webAppService?.sendData(data);

  @override
  void expand() => _webAppService?.expand();
}

/// Заглушка для не-веб платформ
class TelegramServiceStub implements TelegramService {
  @override
  bool get isAvailable => false;

  @override
  void init() {}

  @override
  Map<String, dynamic>? getUserData() => null;

  @override
  String? getTheme() => null;

  @override
  Map<String, String>? getStartParam() => null;

  @override
  void showMainButton({required String text, required VoidCallback onTap}) {}

  @override
  void hideMainButton() {}

  @override
  void showAlert(String message) {}

  @override
  Future<bool> showConfirm(String message) async => false;

  @override
  void setBackgroundColor(String color) {}

  @override
  void setHeaderColor(String color) {}

  @override
  void close() {}

  @override
  void sendData(String data) {}

  @override
  void expand() {}
}

