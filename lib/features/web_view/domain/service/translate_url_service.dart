abstract class TranslateUrlService {
  Uri normalize(String raw);
  String normalizeLang(String code);
  bool isTranslateHost(Uri uri);
  Uri toTranslatedUri(Uri uri, String locale, {String source = 'auto'});
  Uri stripTranslated(Uri uri);
}
