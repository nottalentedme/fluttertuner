import 'package:fluttertuner/feature/settings/repository/theme_repository_interface.dart';
import 'package:fluttertuner/feature/settings/storage/theme_storage.dart';

class ThemeRepositoryImp implements ThemeRepository {
  ThemeRepositoryImp(this.themeStorage);

  final ThemeStorage themeStorage;

  @override
  Future<bool> isDarkTheme() async {
    return await themeStorage.isDarkTheme();
  }

  @override
  Future<void> selectedDarkorLight(bool selected) async {
    return await themeStorage.selectedDarkorLight(selected);
  }
}
