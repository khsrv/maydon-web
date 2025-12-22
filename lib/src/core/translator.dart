/// Превращает обычный URL в прокси Google Translate вида:
/// https://www-example-com.translate.goog/path?existing=1&_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en
///
/// [url] — исходная ссылка (может быть без схемы, напр. "example.com").
/// [locale] — целевой язык ("en", "ru", "tg"...).
///
/// Если на вход уже пришёл translate.goog — просто обновит параметры `_x_tr_*`.
String toGoogleTranslatedUrl(
  String url,
  String locale, {
  String source = 'auto',
}) {
  final orig = _normalizeUrl(url);
  final lang = _normalizeLang(locale);

  // Если уже translate.goog — не трогаем хост, только параметрами язык обновим
  if (orig.host.endsWith('.translate.goog')) {
    final qp = Map<String, String>.from(orig.queryParameters)
      ..['_x_tr_sl'] = source
      ..['_x_tr_tl'] = lang
      ..['_x_tr_hl'] = lang;
    return orig.replace(queryParameters: qp).toString();
  }

  // Иначе строим translate-хост из оригинального
  final translatedHost = _toTranslateGoogHost(orig.host);
  final qp = Map<String, String>.from(orig.queryParameters)
    ..['_x_tr_sl'] = source
    ..['_x_tr_tl'] = lang
    ..['_x_tr_hl'] = lang;

  final translated = orig.replace(
    scheme: orig.scheme.isEmpty ? 'https' : orig.scheme,
    host: translatedHost,
    queryParameters: qp,
  );
  return translated.toString();
}

// ---------- helpers ----------

Uri _normalizeUrl(String raw) {
  var s = raw.trim();
  if (s.isEmpty) return Uri.parse('about:blank');
  s = s.replaceAll(' ', '%20');
  if (!s.contains('://')) s = 'https://$s';
  return Uri.parse(s);
}

String _normalizeLang(String code) {
  final c = code.toLowerCase();
  if (c.contains('-')) return c.split('-').first; // 'en-US' -> 'en'
  if (c.contains('_')) return c.split('_').first; // 'ru_RU' -> 'ru'
  return c;
}

/// Делает из "www.Maydon.ru" → "www-Maydon-ru.translate.goog"
/// и из "Maydon.ru" → "www-Maydon-ru.translate.goog".
String _toTranslateGoogHost(String host) {
  var dashed = host.replaceAll('.', '-');
  if (!dashed.startsWith('www-')) dashed = 'www-$dashed';
  return '$dashed.translate.goog';
}
