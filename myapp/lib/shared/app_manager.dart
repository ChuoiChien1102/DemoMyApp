

import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  final String _firstTimeOpenAppKey = "firstTimeOpenAppKey";
  final String _tokenKey = "tokenKey";
  final String _firebaseTokenKey = "firebaseTokenKey";
  final String _tempTokenKey = "tempTokenKey";
  final String _searchHistoryKey = "searchHistoryKey";
  final String _email = "email";
  final String _password = "password";
  final String _statusFaceId = "statusFaceId";
  final String _isStaff = "_isStaff";

  bool isSignedIn = false;

  AppManager();

  Future<bool> isFirstTimeOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getBool(_firstTimeOpenAppKey) ?? true;
    return data;
  }

  Future<bool> saveIsFirstTimeOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_firstTimeOpenAppKey, false);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_tokenKey);
    isSignedIn = data != null;
    return data;
  }

  Future<String?> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_firebaseTokenKey);
    return data;
  }

  Future<bool> saveToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    isSignedIn = true;
    return prefs.setString(_tokenKey, token);
  }

  Future<bool> saveFirebaseToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_firebaseTokenKey, token);
  }

  Future<bool> saveTempTokenForgotPassword({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tempTokenKey, token);
  }

  Future<bool> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    isSignedIn = false;
    return prefs.remove(_tokenKey);
  }

  Future<bool> saveSearchHistory(
      {required List<String> listSearchHistory}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_searchHistoryKey, listSearchHistory);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_searchHistoryKey) ?? [];
    return data;
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_email);
    return data;
  }

  Future<bool> saveEmail({required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_email, email);
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_password);
    return data;
  }

  Future<bool> savePassword({required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_password, password);
  }

  Future<bool> setStatusFaceId({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_statusFaceId, value);
  }

  Future<bool?> getStatusFaceId() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getBool(_statusFaceId);
    return data;
  }

  Future<bool> setIsStaff({required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_isStaff, value);
  }

  Future<int?> getIsStaff() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getInt(_isStaff);
    return data;
  }
}