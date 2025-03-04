import 'dart:convert';

import 'package:ecommerce/features/auth/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _keyUserEmail = "user_email";
  static const String _keyToken = "token";
  static const String _keyUserData = "user-data";

  String? token;
  ProfileModel? profileModel;

  static Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  static Future<void> clearEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserEmail);
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  static Future<void> saveUserData(ProfileModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserData, jsonEncode(model.toJson()));
  }

  static Future<ProfileModel?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? json = prefs.getString(_keyUserData);
    if (json != null) {
      return ProfileModel.fromJson(jsonDecode(json));
    }
    return null;
  }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserData);
  }

  Future<bool> isLoggedIn() async {
    String? token = getToken() as String?;
    if(token != null) {
      profileModel = getUserData() as ProfileModel?;
      return true;
    }
    return false;
  }


  Future<void> clearAllData() async {
    await clearEmail();
    await clearToken();
    await clearUserData();
  }
}
