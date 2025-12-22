// path: lib/src/core/telegram/telegram_service_factory.dart
import 'package:flutter/foundation.dart';
import 'telegram_service.dart';

/// Фабрика для создания TelegramService
/// Создает реальную реализацию на веб-платформе, заглушку на других
TelegramService createTelegramService() {
  if (kIsWeb) {
    try {
      return TelegramServiceImpl();
    } catch (e) {
      return TelegramServiceStub();
    }
  }
  return TelegramServiceStub();
}

