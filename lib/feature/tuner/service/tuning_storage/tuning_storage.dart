import 'dart:convert';
import 'package:fluttertuner/feature/tuner/data/models/tuning_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuningStorage {
  static const _key = 'custom_tunings';

  Future<void> saveCustomTuning(TuningModel tuning) async {
    final prefs = await SharedPreferences.getInstance();
    final tuningsJson = prefs.getStringList(_key) ?? [];
    tuningsJson.add(jsonEncode(tuning.toJson()));
    await prefs.setStringList(_key, tuningsJson);
  }

  Future<List<TuningModel>> loadCustomTunings() async {
    final prefs = await SharedPreferences.getInstance();
    final tuningsJson = prefs.getStringList(_key) ?? [];
    return tuningsJson
        .map((jsonStr) => TuningModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }
}
