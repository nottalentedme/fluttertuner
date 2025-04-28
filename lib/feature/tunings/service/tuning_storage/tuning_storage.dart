import 'dart:convert';
import 'package:fluttertuner/feature/tunings/data/models/tuning_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuningStorage {
  static const _key = 'custom_tunings';

  Future<void> saveCustomTuning(TuningModel tuning) async {
    final prefs = await SharedPreferences.getInstance();
    final tuningsJson = prefs.getStringList(_key) ?? [];
    tuningsJson.add(jsonEncode(tuning.toJson()));
    await prefs.setStringList(_key, tuningsJson);
  }

  Future<void> deleteCustomTuning(String tuningName) async {
    final prefs = await SharedPreferences.getInstance();
    final tuningsJson = prefs.getStringList(_key) ?? [];

    final updatedTunings = tuningsJson.where((tuningString) {
      final tuningMap = jsonDecode(tuningString) as Map<String, dynamic>;
      return tuningMap['name'] != tuningName;
    }).toList();

    await prefs.setStringList(_key, updatedTunings);
  }

  Future<List<TuningModel>> loadCustomTunings() async {
    final prefs = await SharedPreferences.getInstance();
    final tuningsJson = prefs.getStringList(_key) ?? [];
    return tuningsJson
        .map((jsonStr) => TuningModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }
}
