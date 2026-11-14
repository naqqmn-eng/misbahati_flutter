import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService(this._prefs);
  final SharedPreferences _prefs;
  int get count => _prefs.getInt('count') ?? 0;
  int get target => _prefs.getInt('target') ?? 33;
  String get dhikr => _prefs.getString('dhikr') ?? 'سُبْحَانَ الله';
  bool get haptics => _prefs.getBool('haptics') ?? true;
  String get themeMode => _prefs.getString('themeMode') ?? 'light';
  Future<void> saveThemeMode(String value) => _prefs.setString('themeMode', value);
  Future<void> saveCount(int value) => _prefs.setInt('count', value);
  Future<void> saveTarget(int value) => _prefs.setInt('target', value);
  Future<void> saveDhikr(String value) => _prefs.setString('dhikr', value);
  Future<void> saveHaptics(bool value) => _prefs.setBool('haptics', value);
}
