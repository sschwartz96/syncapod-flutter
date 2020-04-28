import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider {
  static const key_access_token = 'access_token';
  static const key_username = 'username';
  static const key_email = 'email';

  FlutterSecureStorage _storage;

  StorageProvider() {
    // instantiate our storage
    _storage = FlutterSecureStorage();
  }

  Future<void> insert(String key, dynamic object) async {
    print('inserting key: $key with value $object');
    return await _storage.write(key: key, value: object);
  }

  Future<void> delete(String key) async => await _storage.delete(key: key);

  dynamic read(String key) async => await _storage.read(key: key);
}
