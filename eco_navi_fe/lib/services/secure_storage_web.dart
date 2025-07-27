import 'package:eco_navi_fe/services/econavi_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static Future<void> saveToken(AuthData authData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('memberId', authData.memberId);
    await prefs.setString('token', authData.token);
  }

  static Future<String?> getMemberId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('memberId');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('memberId');
    await prefs.remove('token');
  }
}
