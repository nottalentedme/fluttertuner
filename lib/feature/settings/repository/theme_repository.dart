import 'package:fluttertuner/feature/settings/repository/theme_repository_interface.dart';
import 'package:fluttertuner/feature/settings/storage/theme_storage.dart';

class ThemeRepositoryImp implements ThemeRepository {
  ThemeRepositoryImp({required this.pref});

  final ThemeStorage pref;

  @override
  Future<bool> isDarkTheme() async {
    return await pref.isDarkTheme();
  }

  @override
  Future<void> selectedDarkorLight(bool selected) async {
    return await pref.selectedDarkorLight(selected);
  }
}
