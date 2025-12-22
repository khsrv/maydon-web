import 'package:postj/features/web_view/domain/enteties/language_prefs_repository.dart';
import 'package:postj/features/web_view/domain/enteties/supported_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePrefsRepositoryImpl implements LanguagePrefsRepository {
  static const _key = 'webview.selected_language';

  @override
  Future<SupportedLanguage?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code == null || code.isEmpty) return null;
    return SupportedLanguage.byCode(code);
    }

  @override
  Future<void> save(SupportedLanguage lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, lang.code);
  }
}
