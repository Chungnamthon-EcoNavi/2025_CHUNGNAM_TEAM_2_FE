import 'package:eco_navi_fe/services/econavi_auth_service.dart';
import 'package:flutter/foundation.dart';

// 웹에서는 shared_preferences 사용, 모바일에서는 flutter_secure_storage 사용
import 'secure_storage_web.dart'
    if (dart.library.io) 'secure_storage_mobile.dart';

Future<void> saveToken(AuthData authData) async {
  await SecureStorage.saveToken(authData);
}

Future<String?> getMemberId() async {
  return await SecureStorage.getMemberId();
}

Future<String?> getToken() async {
  return await SecureStorage.getToken();
}

Future<void> deleteToken() async {
  await SecureStorage.deleteToken();
}
