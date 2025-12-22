// path: lib/src/core/telegram/telegram_web_app_service_stub.dart
// Заглушка для не-веб платформ

/// Заглушка TelegramWebAppService для не-веб платформ
class TelegramWebAppService {
  static bool get isAvailable => false;
  
  dynamic get webApp => null;
  
  void init() {}
  Map<String, dynamic>? getUserData() => null;
  String? getTheme() => null;
  Map<String, String>? getStartParam() => null;
  void showMainButton({required String text, required Function onTap}) {}
  void hideMainButton() {}
  void showAlert(String message) {}
  Future<bool> showConfirm(String message) async => false;
  void setBackgroundColor(String color) {}
  void setHeaderColor(String color) {}
  void close() {}
  void sendData(String data) {}
  void enableClosingConfirmation(bool enable) {}
  void expand() {}
}

