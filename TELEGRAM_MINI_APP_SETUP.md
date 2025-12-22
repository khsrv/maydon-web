# Настройка Telegram Mini App

Это руководство поможет вам настроить Telegram Mini App для запуска Flutter приложения в Telegram, пока идет проверка в магазинах приложений.

## 📋 Что было сделано

1. ✅ Добавлен пакет `js` для работы с JavaScript
2. ✅ Создан сервис `TelegramWebAppService` для интеграции с Telegram Web App API
3. ✅ Обновлен `index.html` для загрузки Telegram Web App SDK
4. ✅ Интегрирован сервис в DI и `main.dart`
5. ✅ Обновлен `manifest.json` для правильного отображения

## ⚙️ Установка зависимостей

Перед началом работы установите зависимости:

```bash
flutter pub get
```

Это установит пакет `js`, необходимый для работы с JavaScript API.

## 🚀 Шаги по настройке

### Шаг 1: Создание Telegram бота

1. Откройте Telegram и найдите бота [@BotFather](https://t.me/BotFather)
2. Отправьте команду `/newbot`
3. Следуйте инструкциям:
   - Введите имя бота (например: `Maydon App`)
   - Введите username бота (например: `maydon_app_bot`)
4. Сохраните полученный **токен API** - он понадобится позже

### Шаг 2: Настройка бота

В [@BotFather](https://t.me/BotFather) выполните следующие команды:

```bash
/setname - установить имя бота
/setdescription - добавить описание
/setabouttext - установить информацию о боте
/setuserpic - загрузить изображение профиля (используйте app_icon.png)
```

### Шаг 3: Сборка веб-версии приложения

Соберите Flutter приложение для веб:

```bash
flutter build web --release
```

После сборки файлы будут в папке `build/web/`

### Шаг 4: Размещение на хостинге с HTTPS

Telegram Mini Apps требуют HTTPS. Варианты хостинга:

#### Вариант A: Firebase Hosting (рекомендуется)

1. Установите Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Войдите в Firebase:
   ```bash
   firebase login
   ```

3. Инициализируйте проект:
   ```bash
   firebase init hosting
   ```

4. Укажите:
   - Public directory: `build/web`
   - Single-page app: `Yes`
   - Automatic builds: `No`

5. Деплой:
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

6. Получите URL вида: `https://your-project.web.app`

#### Вариант B: Vercel

1. Установите Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Деплой:
   ```bash
   flutter build web --release
   cd build/web
   vercel --prod
   ```

#### Вариант C: Netlify

1. Установите Netlify CLI:
   ```bash
   npm install -g netlify-cli
   ```

2. Деплой:
   ```bash
   flutter build web --release
   netlify deploy --prod --dir=build/web
   ```

#### Вариант D: GitHub Pages

1. Создайте репозиторий на GitHub
2. Настройте GitHub Actions для автоматического деплоя
3. Используйте GitHub Pages для хостинга

### Шаг 5: Настройка домена в Telegram

1. В [@BotFather](https://t.me/BotFather) выберите вашего бота
2. Отправьте команду `/setdomain`
3. Укажите домен вашего приложения (без `https://` и без `/`):
   ```
   your-project.web.app
   ```
   или
   ```
   yourdomain.com
   ```

### Шаг 6: Добавление кнопки Mini App в бота

#### Способ 1: Через BotFather (меню бота)

1. В [@BotFather](https://t.me/BotFather) выберите вашего бота
2. Отправьте команду `/setmenubutton`
3. Выберите вашего бота
4. Выберите "Web App"
5. Введите URL вашего приложения:
   ```
   https://your-project.web.app
   ```

#### Способ 2: Через код бота (Inline кнопка)

Если у вас есть бэкенд для бота, вы можете добавить кнопку программно:

```python
from telegram import InlineKeyboardButton, InlineKeyboardMarkup, Update
from telegram.ext import Application, CommandHandler, ContextTypes

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [
        [InlineKeyboardButton(
            "Открыть приложение",
            web_app=WebAppInfo(url="https://your-project.web.app")
        )]
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    await update.message.reply_text(
        "Добро пожаловать! Нажмите кнопку ниже, чтобы открыть приложение.",
        reply_markup=reply_markup
    )

app = Application.builder().token("YOUR_BOT_TOKEN").build()
app.add_handler(CommandHandler("start", start))
app.run_polling()
```

### Шаг 7: Тестирование

1. Откройте Telegram
2. Найдите вашего бота
3. Нажмите на кнопку меню или отправьте `/start`
4. Нажмите на кнопку "Открыть приложение" или кнопку в меню
5. Приложение должно открыться внутри Telegram

## 🔧 Дополнительная настройка

### Настройка цветов под тему Telegram

В `lib/main.dart` можно настроить цвета:

```dart
if (telegramService.isAvailable) {
  telegramService.init();
  
  // Получить тему Telegram
  final theme = telegramService.getTheme();
  
  // Установить цвет фона
  if (theme == 'dark') {
    telegramService.setBackgroundColor('#000000');
  } else {
    telegramService.setBackgroundColor('#FFFFFF');
  }
  
  // Установить цвет заголовка
  telegramService.setHeaderColor('#FFFFFF');
  
  telegramService.expand();
}
```

### Получение данных пользователя

```dart
final telegramService = getIt<TelegramService>();
if (telegramService.isAvailable) {
  final userData = telegramService.getUserData();
  // userData содержит информацию о пользователе Telegram
  print('User ID: ${userData?['user']?['id']}');
  print('Username: ${userData?['user']?['username']}');
  print('First Name: ${userData?['user']?['first_name']}');
}
```

### Использование главной кнопки

```dart
telegramService.showMainButton(
  text: 'Отправить',
  onTap: () {
    // Действие при нажатии
    telegramService.sendData('{"action": "submit"}');
  },
);
```

### Показ всплывающих окон

```dart
telegramService.showAlert('Привет из Telegram Mini App!');

// Или подтверждение
final confirmed = await telegramService.showConfirm('Вы уверены?');
if (confirmed) {
  // Действие
}
```

## 📱 Проверка работы

После настройки проверьте:

1. ✅ Приложение открывается в Telegram
2. ✅ Приложение занимает весь экран
3. ✅ Цвета соответствуют теме Telegram
4. ✅ Все функции приложения работают
5. ✅ Нет ошибок в консоли браузера

## 🐛 Решение проблем

### Приложение не открывается

- Проверьте, что домен правильно настроен в BotFather
- Убедитесь, что используется HTTPS
- Проверьте, что URL доступен публично

### Ошибки JavaScript

- Убедитесь, что Telegram Web App SDK загружается в `index.html`
- Проверьте консоль браузера на наличие ошибок
- Убедитесь, что используется последняя версия SDK

### Приложение не на весь экран

- Вызовите `telegramService.expand()` после инициализации
- Проверьте, что `init()` вызывается

### Цвета не соответствуют теме

- Используйте `telegramService.getTheme()` для определения темы
- Настройте цвета соответственно

## 📚 Полезные ссылки

- [Telegram Bot API Documentation](https://core.telegram.org/bots/api)
- [Telegram Web App API](https://core.telegram.org/bots/webapps)
- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)
- [Firebase Hosting](https://firebase.google.com/docs/hosting)
- [Vercel Documentation](https://vercel.com/docs)

## 🎉 Готово!

Теперь ваше приложение доступно как Telegram Mini App! Пользователи могут открыть его прямо в Telegram, пока идет проверка в магазинах приложений.

