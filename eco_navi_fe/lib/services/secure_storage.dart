import 'package:eco_navi_fe/models/auth_data.dart';
import 'package:eco_navi_fe/models/point.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_navi_fe/models/user.dart';

Future<void> saveToken(AuthData authData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('memberId', authData.memberId);
  await prefs.setString('token', authData.token);
}

Future<String?> getMemberId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('memberId');
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<void> deleteToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('memberId');
  await prefs.remove('token');
}

/// 토큰이 존재하는지 확인
Future<bool> hasToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
}

/// memberId가 존재하는지 확인
Future<bool> hasMemberId() async {
  final prefs = await SharedPreferences.getInstance();
  final memberId = prefs.getString('memberId');
  return memberId != null && memberId.isNotEmpty;
}

/// 로그인 상태 확인 (토큰과 memberId 모두 있는지)
Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final memberId = prefs.getString('memberId');
  return token != null &&
      token.isNotEmpty &&
      memberId != null &&
      memberId.isNotEmpty;
}

/// 저장된 모든 인증 데이터 가져오기
Future<AuthData?> getAuthData() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final memberId = prefs.getString('memberId');

  if (token != null &&
      memberId != null &&
      token.isNotEmpty &&
      memberId.isNotEmpty) {
    return AuthData(memberId: memberId, token: token);
  }
  return null;
}

Future<void> saveUser(User user) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('id', user.id);
  await prefs.setString('username', user.username);
  await prefs.setString('name', user.name);
  await prefs.setString('role', user.role);
  await prefs.setString('createdAt', user.createdAt);
  await prefs.setString('updatedAt', user.updatedAt);
}

Future<User?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  return User(
    id: prefs.getInt('id') as int,
    username: prefs.getString('username') as String,
    name: prefs.getString('name') as String,
    role: prefs.getString('role') as String,
    createdAt: prefs.getString('createdAt') as String,
    updatedAt: prefs.getString('updatedAt') as String,
  );
}

Future<void> deleteUser() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('id');
  await prefs.remove('username');
  await prefs.remove('name');
  await prefs.remove('role');
  await prefs.remove('createdAt');
  await prefs.remove('updatedAt');
}

Future<void> savePoint(Point point) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('memberId', point.memberId);
  await prefs.setInt('amount', point.amount);
  await prefs.setString('updatedAt', point.updatedAt);
}

Future<Point> getPoint() async {
  final prefs = await SharedPreferences.getInstance();
  return Point(
    memberId: prefs.getInt('memberId') as int,
    amount: prefs.getInt('amount') as int,
    updatedAt: prefs.getString('updatedAt') as String,
  );
}

Future<void> deletePoint() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('memberId');
  await prefs.remove('amount');
  await prefs.remove('updatedAt');
}
