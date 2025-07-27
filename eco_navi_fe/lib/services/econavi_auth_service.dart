import 'dart:convert';
import 'dart:js_interop';

import 'package:eco_navi_fe/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class User {
  final String username;
  final String name;
  final String role;
  final String password;

  User({
    required this.username,
    required this.name,
    required this.role,
    required this.password,
  });
}

class AuthData {
  final String memberId;
  final String token;

  AuthData({required this.memberId, required this.token});
}

class EconaviAuthService {
  static Future<void> signUp({
    required String username,
    required String name,
    required String role,
    required String password,
  }) async {
    final url = Uri.parse('https://econavi.mobidic.shop/auth/signup');

    final Map<String, dynamic> body = {
      'username': username,
      'name': name,
      'role': role,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Sign up successful: ${response.body}');
      } else {
        print('Sign up failed: ${response.statusCode} - ${response.body}');
        throw Exception('Auth API error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  static Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    final url = Uri.https('econavi.mobidic.shop', '/auth/login');

    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode(body),
    );

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    saveToken(AuthData(memberId: json['memberId'], token: json['token']));
    print(json['memberId']);
  }

  static Future<void> logOut({
    required String username,
    required String name,
    required String role,
    required String password,
  }) async {
    final Map<String, dynamic> body = {};

    final url = Uri.https('econavi.mobidic.shop', '/auth/logout');

    final resp = await http.post(
      url,
      headers: {'accept': '*/*'},
      body: jsonEncode(body),
    );

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    deleteToken();
  }
}
