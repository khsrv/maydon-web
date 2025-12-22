import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:postj/src/theme/app_theme.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  Future<void> _openStore() async {
    final String url;
    if (Platform.isIOS) {
      // Ссылка на App Store для приложения "Майдон"
      url = 'https://apps.apple.com/us/app/майдон/id6756840511';
    } else if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=com.maydon';
    } else {
      return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback: открываем в браузере
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Запрещаем возврат назад
      child: Scaffold(
        backgroundColor: kWebViewBgLight,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Иконка обновления
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: kWebViewHeaderBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.system_update,
                    size: 64,
                    color: kWebViewHeaderBlue,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Заголовок
                Text(
                  'Обновление приложения',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // Описание
                Text(
                  'Для продолжения использования приложения необходимо обновить его до последней версии.\n\nОбновление включает новые функции и улучшения.',
                  style: const TextStyle(
                    fontSize: 16,
                    color: kGrey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Кнопка обновления
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _openStore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kWebViewHeaderBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download, color: kWhite),
                        const SizedBox(width: 12),
                        Text(
                          Platform.isIOS ? 'Обновить в App Store' : 'Обновить в Google Play',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Информация
                Text(
                  'После обновления приложение откроется автоматически',
                  style: const TextStyle(
                    fontSize: 14,
                    color: kGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

