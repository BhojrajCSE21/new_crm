import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  /// Write the token to secure storage
  Future<void> writeToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  /// Read the token from secure storage
  Future<String?> readToken() async {
    return await _storage.read(key: 'access_token');
  }

  /// Delete the token from secure storage
  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }

  /// Clear all data from secure storage (used during logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
