import 'package:fluttertuner/feature/settings/repository/theme_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepositoryImp implements ThemeRepository{
  ThemeRepositoryImp({required this.pref});

  final SharedPreferences pref;

  static const _isDarkThemeSelectedKey = 'theme_selected';

  @override
  bool isDarkTheme(){
    final selected = pref.getBool(_isDarkThemeSelectedKey);//Если нет ключа
    return selected ?? false;
  }

  @override
  Future<void> selectedDarkorLightThemePonomorovmethod(bool selected) async {
    await pref.setBool(_isDarkThemeSelectedKey, selected);
  }
}
