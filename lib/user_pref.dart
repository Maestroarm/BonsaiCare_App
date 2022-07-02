import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static late SharedPreferences _preferences;

  static const _keyName = 'name';

  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();

  static Future setName(String name) async =>
      await _preferences.setString(_keyName, name);

  static String? getName() => _preferences.getString(_keyName);
}

