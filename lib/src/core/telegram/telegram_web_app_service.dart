// path: lib/src/core/telegram/telegram_web_app_service.dart
// ignore_for_file: avoid_web_libraries_in_flutter, uri_does_not_exist
// Этот файл используется только на веб-платформе через условные импорты
// Анализатор может показывать ошибки, но они не влияют на компиляцию для веб

import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'package:flutter/foundation.dart';

/// Сервис для работы с Telegram Web App API
class TelegramWebAppService {
  static bool get isAvailable {
    try {
      final window = html.window;
      return js_util.hasProperty(window, 'Telegram') ||
          js_util.hasProperty(window, 'telegram');
    } catch (e) {
      return false;
    }
  }

  /// Получить объект Telegram WebApp
  dynamic get _webApp {
    if (!isAvailable) return null;
    try {
      final window = html.window;
      if (js_util.hasProperty(window, 'Telegram')) {
        return js_util.getProperty(window, 'Telegram');
      } else if (js_util.hasProperty(window, 'telegram')) {
        return js_util.getProperty(window, 'telegram');
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Получить WebApp объект
  dynamic get webApp {
    final telegram = _webApp;
    if (telegram == null) return null;
    try {
      return js_util.getProperty(telegram, 'WebApp');
    } catch (e) {
      return null;
    }
  }

  /// Инициализация Telegram Web App
  void init() {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app != null) {
        // Расширяем приложение на весь экран
        js_util.callMethod(app, 'expand', []);
        // Включаем закрытие через свайп вниз
        js_util.setProperty(app, 'enableClosingConfirmation', false);
      }
    } catch (e) {
      // Игнорируем ошибки, если Telegram API недоступен
    }
  }

  /// Получить данные пользователя
  Map<String, dynamic>? getUserData() {
    if (!isAvailable) return null;
    try {
      final app = webApp;
      if (app == null) return null;
      
      final user = js_util.getProperty(app, 'initDataUnsafe');
      
      if (user != null) {
        return _convertJsObjectToMap(user);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Получить тему Telegram
  String? getTheme() {
    if (!isAvailable) return null;
    try {
      final app = webApp;
      if (app == null) return null;
      
      final colorScheme = js_util.getProperty(app, 'colorScheme');
      return colorScheme?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Получить параметры запуска (query params)
  Map<String, String>? getStartParam() {
    if (!isAvailable) return null;
    try {
      final app = webApp;
      if (app == null) return null;
      
      final startParam = js_util.getProperty(app, 'startParam');
      if (startParam != null) {
        return {'startParam': startParam.toString()};
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Показать главную кнопку
  void showMainButton({required String text, required VoidCallback onTap}) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      final mainButton = js_util.getProperty(app, 'MainButton');
      if (mainButton != null) {
        js_util.setProperty(mainButton, 'text', text);
        js_util.setProperty(mainButton, 'isVisible', true);
        
        // Удаляем предыдущие обработчики и добавляем новый
        js_util.callMethod(mainButton, 'onClick', [
          js.allowInterop(() => onTap()),
        ]);
      }
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Скрыть главную кнопку
  void hideMainButton() {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      final mainButton = js_util.getProperty(app, 'MainButton');
      if (mainButton != null) {
        js_util.setProperty(mainButton, 'isVisible', false);
      }
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Показать всплывающее окно
  void showPopup({
    required String title,
    required String message,
    required List<PopupButton> buttons,
  }) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      final popupButtons = buttons.map((btn) {
        return js_util.jsify({
          'id': btn.id,
          'type': btn.type,
          'text': btn.text,
        });
      }).toList();
      
      js_util.callMethod(app, 'showPopup', [
        js_util.jsify({
          'title': title,
          'message': message,
          'buttons': popupButtons,
        }),
        js.allowInterop((String buttonId) {
          final button = buttons.firstWhere(
            (btn) => btn.id == buttonId,
            orElse: () => buttons.first,
          );
          button.onTap?.call();
        }),
      ]);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Показать алерт
  void showAlert(String message) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'showAlert', [message]);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Показать подтверждение
  Future<bool> showConfirm(String message) async {
    if (!isAvailable) return false;
    try {
      final app = webApp;
      if (app == null) return false;
      
      final completer = Completer<bool>();
      
      js_util.callMethod(app, 'showConfirm', [
        message,
        js.allowInterop((bool confirmed) {
          completer.complete(confirmed);
        }),
      ]);
      
      return completer.future;
    } catch (e) {
      return false;
    }
  }

  /// Установить цвет фона
  void setBackgroundColor(String color) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'setBackgroundColor', [color]);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Установить цвет заголовка
  void setHeaderColor(String color) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'setHeaderColor', [color]);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Закрыть приложение
  void close() {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'close', []);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Отправить данные в бота
  void sendData(String data) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'sendData', [data]);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Включить/выключить закрытие через свайп вниз
  void enableClosingConfirmation(bool enable) {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.setProperty(app, 'enableClosingConfirmation', enable);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Расширить приложение на весь экран
  void expand() {
    if (!isAvailable) return;
    try {
      final app = webApp;
      if (app == null) return;
      
      js_util.callMethod(app, 'expand', []);
    } catch (e) {
      // Игнорируем ошибки
    }
  }

  /// Конвертировать JS объект в Map
  Map<String, dynamic>? _convertJsObjectToMap(dynamic jsObject) {
    if (jsObject == null) return null;
    
    try {
      final result = <String, dynamic>{};
      final keys = js_util.objectKeys(jsObject);
      
      for (var key in keys) {
        if (key == null) continue;
        final value = js_util.getProperty(jsObject, key as Object);
        if (value is String || value is num || value is bool) {
          result[key.toString()] = value;
        } else if (value != null) {
          result[key.toString()] = value.toString();
        }
      }
      
      return result;
    } catch (e) {
      return null;
    }
  }
}

/// Кнопка для popup
class PopupButton {
  final String id;
  final String type; // 'default' или 'ok'
  final String text;
  final VoidCallback? onTap;

  PopupButton({
    required this.id,
    this.type = 'default',
    required this.text,
    this.onTap,
  });
}
