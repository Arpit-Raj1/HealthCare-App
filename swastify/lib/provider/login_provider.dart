import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String? _token;
  String? _uid;

  String? get token => _token;
  String? get uid => _uid;

  bool get isLoggedIn =>
      _token != null && _token!.isNotEmpty && _uid != null && _uid!.isNotEmpty;

  /// Load token from local storage (SharedPreferences)
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    _uid = prefs.getString("uid");
    notifyListeners();
  }

  /// Save token both in memory and local storage
  Future<void> setToken(String newToken, String newUid) async {
    _token = newToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', newToken);
    _uid = newUid;
    await prefs.setString('uid', newUid);
    notifyListeners();
  }

  /// Clear token from memory and local storage
  Future<void> clearToken() async {
    _token = null;
    _uid = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('uid');
    notifyListeners();
  }
}
