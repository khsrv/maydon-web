
// path: lib/src/core/security/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStore {
  AuthTokenStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';

  Future<String?> getAccessToken() => _storage.read(key: _kAccessToken);

  Future<void> setAccessToken(String token) =>
      _storage.write(key: _kAccessToken, value: token);

  Future<void> clearTokens() async {
    await _storage.delete(key: _kAccessToken);
    await _storage.delete(key: _kRefreshToken);
  }

  Future<String?> getRefreshToken() => _storage.read(key: _kRefreshToken);
  Future<void> setRefreshToken(String token) =>
      _storage.write(key: _kRefreshToken, value: token);
}
