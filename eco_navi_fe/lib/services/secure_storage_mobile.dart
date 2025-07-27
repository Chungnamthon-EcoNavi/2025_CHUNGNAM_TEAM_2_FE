import 'package:eco_navi_fe/services/econavi_auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveToken(AuthData authData) async {
    await _storage.write(key: "memberId", value: authData.memberId);
    await _storage.write(key: "token", value: authData.token);
  }

  static Future<String?> getMemberId() async {
    return await _storage.read(key: "memberId");
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "token");
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: "memberId");
    await _storage.delete(key: "token");
  }
}
