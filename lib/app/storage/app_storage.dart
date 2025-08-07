
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static final AppStorage _instance = AppStorage._internal();

  factory AppStorage() => _instance;

  AppStorage._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Token Setter
  Future<void> setToken(String token) async {
    await _prefs?.setString(StorageKeys.token, token);
  }

  /// Token Getter
  String? getToken() {
    return _prefs?.getString(StorageKeys.token);
  }

  /// Remove Token
  Future<void> clearToken() async {
    await _prefs?.remove(StorageKeys.token);
  }

  /// Clear all
  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}


class StorageKeys {
  static const String token = 'token';
} 