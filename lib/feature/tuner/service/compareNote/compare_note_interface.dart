import 'package:fluttertuner/feature/tuner/domain/models/tuning_model.dart';
import 'package:pitch_detector_dart/pitch_detector_result.dart';

abstract interface class CompareNote {
  double compareWithString(PitchDetectorResult pitch, TuningModel note);
  //TODO хз заюзать нарн сервис этот в кубите
}
