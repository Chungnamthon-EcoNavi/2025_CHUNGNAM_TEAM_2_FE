// providers/auth_data_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_navi_fe/models/auth_data.dart';

class AuthDataViewModel extends ChangeNotifier {
  AuthData _authData = AuthData(memberId: '', token: '');

  AuthData get authData => _authData;
  String get memberId => _authData.memberId;
  String get token => _authData.token;

  set memberId(String value) {
    _authData = AuthData(memberId: value, token: _authData.token);
    notifyListeners();
  }

  set token(String value) {
    _authData = AuthData(memberId: _authData.memberId, token: value);
    notifyListeners();
  }

  void logout() {
    _authData = AuthData(memberId: '', token: '');
    notifyListeners();
  }
}

final authDataProvider = ChangeNotifierProvider<AuthDataViewModel>((ref) {
  return AuthDataViewModel();
});
