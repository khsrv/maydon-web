import 'package:postj/features/web_view/domain/enteties/supported_language.dart';

abstract class LanguagePrefsRepository {
  Future<SupportedLanguage?> read();
  Future<void> save(SupportedLanguage lang);
}
