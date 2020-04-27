import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const _key_access_token = 'access_token';

  FlutterSecureStorage _storage;

  Storage() {
    // instantiate our storage
    _storage = FlutterSecureStorage();
  }

  void insertAccessToken(String token) async =>
      await _storage.write(key: _key_access_token, value: token);

  void removeAccessToken() {
    _storage.delete(key: _key_access_token);
  }

  Future<String> getAccessToken() async =>
      await _storage.read(key: _key_access_token);
}
