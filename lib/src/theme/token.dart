
// path: lib/src/theme/token.dart
import 'package:flutter/material.dart';

class AppToken {
  static const colors = _AppColors();
  static const spacing = _AppSpacing();
  static const radius = _AppRadius();
  static final typography = _AppTypography();
}

class _AppColors {
  const _AppColors();

  final Color primary = const Color(0xFF4F46E5);
  final Color onPrimary = Colors.white;
  final Color secondary = const Color(0xFF10B981);
  final Color error = const Color(0xFFEF4444);

  final Color surface = const Color(0xFFF8FAFC);
  final Color onSurface = const Color(0xFF0F172A);

  final Color gray100 = const Color(0xFFF1F5F9);
  final Color gray200 = const Color(0xFFE2E8F0);
  final Color gray300 = const Color(0xFFCBD5E1);
  final Color gray600 = const Color(0xFF475569);
  final Color gray800 = const Color(0xFF1F2937);
}

class _AppSpacing {
  const _AppSpacing();

  final double xs = 4;
  final double sm = 8;
  final double md = 12;
  final double lg = 16;
  final double xl = 24;
  final double xxl = 32;
}

class _AppRadius {
  const _AppRadius();

  final BorderRadius small = const BorderRadius.all(Radius.circular(8));
  final BorderRadius medium = const BorderRadius.all(Radius.circular(12));
  final BorderRadius large = const BorderRadius.all(Radius.circular(16));
  final BorderRadius xlarge = const BorderRadius.all(Radius.circular(24));
  final double circular = 999;
}

class _AppTypography {
  TextTheme toTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? Typography.whiteRedmond
        : Typography.blackRedmond;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(height: 1.3),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.3),
      labelLarge: base.labelLarge?.copyWith(letterSpacing: 0.2),
    );
  }
}
