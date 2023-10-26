import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  final String _token = "uid";
  final String _email = "email";
  final String _password = "password";
  static LocalPreferences? _instance;
  SharedPreferences? _sharedPreferences;

  LocalPreferences._();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static LocalPreferences get instance {
    _instance ??= LocalPreferences._();
    return _instance!;
  }

  void setToken(String token) {
    _sharedPreferences!.setString(_token, token);
  }

  void setEmail(String email) {
    _sharedPreferences!.setString(_email, email);
  }

  void setPassword(String password) {
    _sharedPreferences!.setString(_password, password);
  }

  Future<String?> getToken() async {
    return _sharedPreferences!.getString(_token);
  }

  String? getPassword() {
    return _sharedPreferences!.getString(_password);
  }

  String? getEmail() {
    return _sharedPreferences!.getString(_email);
  }

  void clearePrefs() {
    _sharedPreferences?.clear();
  }
}
