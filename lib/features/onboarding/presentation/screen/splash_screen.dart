import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Логотип или иконка мяча
            _buildLogo(),
            const SizedBox(height: 24),
            // Индикатор загрузки
            const CupertinoActivityIndicator(),
            const SizedBox(height: 16),
            // Текст "Загрузка..."
            Text(
              'Загрузка...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: cs.onSurface.withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logo/app_icon.png',
      width: 120,
      height: 120,
      errorBuilder: (context, error, stackTrace) {
        // Если логотип не загрузился, показываем иконку мяча
        return const Icon(
          Icons.sports_soccer,
          size: 120,
          color: Colors.blue,
        );
      },
    );
  }
}