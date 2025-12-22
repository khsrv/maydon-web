
// path: lib/src/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'token.dart';


const kBlack = Color(0xFF000000);
const kWhite = Color(0xFFFFFFFF);
const kBlue = Color(0xFF007DFF);
const kRed = Color(0xFFFF505F);
const kGreen = Color(0xFF4CAF50);
const kYellow = Color(0xFFFF9800);
const kViolet = Color(0xFF7B61FF);
const kOrange = Color(0xFFF25C05);
const kGreyLight = Color(0xFF5D5D5D);
const kGrey = Color(0xFF343434);
const kTrans = Colors.transparent;
const kGreyBgColor = Color(0xFF111111);
// Цвета для WebView (темно-синий фон как на сайте)
const kWebViewHeaderBlue = Color(0xFF113356); // Темно-синий для header и overlay
const kWebViewBgLight = Color(0xFFF1F5F9); // Светло-серый для основного контента

class AppTheme {
  static ThemeData light() {
    final brightness = Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppToken.colors.primary,
      brightness: brightness,
      primary: AppToken.colors.primary,
      onPrimary: AppToken.colors.onPrimary,
      error: AppToken.colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: AppToken.typography.toTextTheme(brightness),
      scaffoldBackgroundColor: AppToken.colors.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: AppToken.colors.surface,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppToken.colors.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: AppToken.radius.large),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppToken.radius.medium,
        ),
        contentPadding: const EdgeInsets.all(14),
      ),
    );
  }

  static ThemeData dark() {
    final brightness = Brightness.dark;

    final colorScheme = ColorScheme.fromSeed(

      seedColor: AppToken.colors.primary,
      brightness: brightness,
      primary: AppToken.colors.primary,
      error: AppToken.colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: AppToken.typography.toTextTheme(brightness),
    );
  }
}
