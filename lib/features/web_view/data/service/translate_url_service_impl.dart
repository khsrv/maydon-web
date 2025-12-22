
import 'package:postj/features/web_view/domain/service/translate_url_service.dart';

class TranslateUrlServiceImpl implements TranslateUrlService {
  @override
  Uri normalize(String raw) {
    var s = raw.trim();
    if (s.isEmpty) return Uri.parse('about:blank');
    s = s.replaceAll(' ', '%20');
    if (!s.contains('://')) s = 'https://$s';
    return Uri.parse(s);
  }

  @override
  String normalizeLang(String code) {
    var c = code.trim();
    if (c.isEmpty) return 'ru';
    c = c.replaceAll('_', '-').toLowerCase();
    if (c == 'zh') return 'zh-CN';
    return c;
  }

  @override
  bool isTranslateHost(Uri uri) => uri.host.endsWith('.translate.goog');

  @override
  Uri toTranslatedUri(Uri uri, String locale, {String source = 'auto'}) {
    final lang = normalizeLang(locale);

    if (isTranslateHost(uri)) {
      final qp = Map<String, String>.from(uri.queryParameters)
        ..['_x_tr_sl'] = source
        ..['_x_tr_tl'] = lang
        ..['_x_tr_hl'] = lang;
      return uri.replace(queryParameters: qp);
    }

    final translatedHost = _toTranslateGoogHost(uri.host);
    final qp = Map<String, String>.from(uri.queryParameters)
      ..['_x_tr_sl'] = source
      ..['_x_tr_tl'] = lang
      ..['_x_tr_hl'] = lang;

    return uri.replace(
      scheme: uri.scheme.isEmpty ? 'https' : uri.scheme,
      host: translatedHost,
      queryParameters: qp,
    );
  }

  @override
  Uri stripTranslated(Uri uri) {
    if (!isTranslateHost(uri)) return uri;

    var host = uri.host;
    host = host.replaceFirst('.translate.goog', '');
    if (host.startsWith('www-')) host = host.substring('www-'.length);
    host = host.replaceAll('-', '.');

    final qp = Map<String, String>.from(uri.queryParameters)
      ..remove('_x_tr_sl')
      ..remove('_x_tr_tl')
      ..remove('_x_tr_hl');

    return uri.replace(host: host, queryParameters: qp);
  }

  String _toTranslateGoogHost(String host) {
    var dashed = host.replaceAll('.', '-');
    if (!dashed.startsWith('www-')) dashed = 'www-$dashed';
    return '$dashed.translate.goog';
  }
}
