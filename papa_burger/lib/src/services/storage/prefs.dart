import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  late final SharedPreferences _prefs;

  static Prefs instance = Prefs();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> deleteData() async {
    await _prefs.remove('token');
    await _prefs.remove('email');
    await _prefs.remove('user_name');
  }

  Future<void> upsertUserInfo(
      String token, String email, String username) async {
    await saveToken(token);
    await saveEmail(email);
    await saveUsername(username);
  }

  Future<void> deleteDuration() async {
    await _prefs.remove('duration');
  }

  Future<bool> saveToken(String token) async {
    return await _prefs.setString('token', token);
  }

  String get getToken => _prefs.getString('token') ?? '';

  Future<String?> getFromToken() async {
    return getToken;
  }

  Future<bool> saveEmail(String email) async {
    return await _prefs.setString('email', email);
  }

  String get getEmail => _prefs.getString('email') ?? '';

  Future<bool> savePassword(String password) async {
    return await _prefs.setString('password', password);
  }

  String get getPassword => _prefs.getString('password') ?? '';

  Future<bool> saveUsername(String username) async {
    return await _prefs.setString('user_name', username);
  }

  String get getUsername => _prefs.getString('user_name') ?? '';

  Future<bool> setFirstInstall() async {
    return await _prefs.setBool('isFirstInstall', true);
  }

  Future<bool> saveTimer(int duration) async {
    return await _prefs.setInt('duration', duration);
  }

  int get getTimer => _prefs.getInt('duration') ?? 60;

  bool get isFirstInstall => _prefs.getBool('isFirstInstall') ?? false;
}
