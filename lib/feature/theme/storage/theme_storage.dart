import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static const _isDarkThemeSelectedKey = 'theme_selected';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }


  Future<bool> isDarkTheme() async {
    final prefs = await _getPrefs();
    final selected = prefs.getBool(_isDarkThemeSelectedKey); //Если нет ключа
    return selected ?? false;
  }

  Future<void> selectedDarkorLight(bool selected) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_isDarkThemeSelectedKey, selected);
  }
}