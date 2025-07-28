import 'dart:convert';
import 'dart:js_interop';

import 'package:eco_navi_fe/models/place.dart';
import 'package:eco_navi_fe/services/secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:eco_navi_fe/models/user.dart';
import 'package:eco_navi_fe/models/point.dart';
import 'package:eco_navi_fe/models/authData.dart';

class AuthService {
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
    //final storage = ref.read(secureStorageProvider);

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    saveToken(AuthData(memberId: json['memberId'], token: json['token']));
    print(json['token']);

    saveUser(await UserApiService.getUser());
    savePoint(await UserApiService.getPoint());
  }

  static Future<void> logOut() async {
    final Map<String, dynamic> body = {};

    final url = Uri.https('econavi.mobidic.shop', '/auth/logout');

    final resp = await http.post(
      url,
      headers: {'Authorization': 'Bearer ${await getToken()}', 'accept': '*/*'},
    );

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    deleteToken();
  }
}

class UserApiService {
  static Future<User> getUser() async {
    final memberId = await getMemberId();
    final Map<String, dynamic> params = {'member_id': memberId};

    final url = Uri.https('econavi.mobidic.shop', '/auth/logout', params);

    final token = await getToken();
    final resp = await http.post(
      url,
      headers: {'Authorization': 'Bearer ${token}', 'accept': '*/*'},
    );

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;

    return User.fromJson(json);
  }

  static Future<Point> getPoint() async {
    final url = Uri.https('econavi.mobidic.shop', '/auth/logout');

    final resp = await http.post(
      url,
      headers: {'Authorization': 'Bearer ${await getToken()}', 'accept': '*/*'},
    );

    if (resp.statusCode != 200) {
      // ← 500·401·400 등 모두 여기로
      throw Exception('Auth API error ${resp.statusCode}: ${resp.body}');
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;

    return Point.fromJson(json);
  }
}

class PlaceApiService {
  static Future<List<Place>> keywordSearch({required String keyword}) async {
    final url = Uri.https('econavi.mobidic.shop', '/place/search', {
      'keyword': keyword,
    });

    final resp = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${await getToken()}', 'accept': '*/*'},
    );

    if (resp.statusCode != 200) {
      throw Exception('Place API error ${resp.statusCode}: ${resp.body}');
    }

    final List<Place> decoded = jsonDecode(resp.body) as List<Place>;
    return decoded
        .map((e) => Place.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Place>> getPlace({
    required double lat,
    required double lng,
    double distance = 1.0,
  }) async {
    //print('$lat , $lng');
    final params = {
      'latitude': lat.toString(),
      'longitude': lng.toString(),
      'distance': distance.toString(),
    };

    try {
      final url = Uri.https('econavi.mobidic.shop', '/place/around', params);

      final resp = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${await getToken()}',
          'accept': '*/*',
        },
      );

      if (resp.statusCode != 200) {
        throw Exception('Place API error ${resp.statusCode}: ${resp.body}');
      }

      final json = (jsonDecode(resp.body) as List?) ?? [];
      return json
          .map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error creating URL: $e');
      throw Exception('Invalid parameters for Place API');
    }
  }
}
