import 'package:fluttertuner/feature/config/dependency.dart';

abstract interface class ThemeRepository extends Repository{
  bool isDarkTheme();
  Future<void> selectedDarkorLightThemePonomorovmethod(bool selected);
}
