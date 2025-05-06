import 'package:fluttertuner/feature/config/dependency.dart';

abstract interface class ThemeRepository extends Repository{
  Future<bool> isDarkTheme();
  Future<void> selectedDarkorLight(bool selected);
}
