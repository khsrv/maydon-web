enum SupportedLanguage {
  ru('ru', 'Русский', '🇷🇺'),
  en('en', 'English', '🇺🇸'),
  ar('ar', 'العربية', '🇸🇦'),
  tr('tr', 'Türkçe', '🇹🇷'),
  zhCN('zh-CN', '中文', '🇨🇳'),
  tg('tg', 'Тоҷикӣ', '🇹🇯'),
  uz('uz', 'Oʻzbekcha', '🇺🇿'),
  ky('ky', 'Кыргызча', '🇰🇬');

  const SupportedLanguage(this.code, this.label, this.flag);
  final String code;
  final String label;
  final String flag;

  static SupportedLanguage byCode(String code) =>
      SupportedLanguage.values.firstWhere(
        (e) => e.code.toLowerCase() == code.toLowerCase(),
        orElse: () => SupportedLanguage.ru,
      );
}
