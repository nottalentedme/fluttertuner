import 'package:pitchupdart/tuning_status.dart';

//TODO вынести enum в domain
enum GuitarString {
  sixthE('E', 82.41),
  fifthA('A', 110.00),
  fourthD('D', 146.83),
  thirdG('G', 196.00),
  secondB('B', 246.94),
  firstE('E', 329.63);

  final String noteName;
  final double frequency;

  const GuitarString(this.noteName, this.frequency);
//TODO вынести методы из енума в сервисы
//TODO надо не смену на следующую, а смену на выбранную кнопкой струну
  GuitarString getNext() {
    const values = GuitarString.values;
    final nextIndex = (values.indexOf(this) + 1) % values.length;
    return values[nextIndex];
  }

  TuningStatus getTuningStatus(double detectedFrequency) {
    const tolerance = 0.10;
    final lowerBound = frequency * (1 - tolerance);
    final upperBound = frequency * (1 + tolerance);

    if (detectedFrequency < lowerBound * 0.8) {
      return TuningStatus.waytoolow;
    } else if (detectedFrequency < lowerBound) {
      return TuningStatus.toolow;
    } else if (detectedFrequency > upperBound * 1.2) {
      return TuningStatus.waytoohigh;
    } else if (detectedFrequency > upperBound) {
      return TuningStatus.toohigh;
    } else {
      return TuningStatus.tuned;
    }
  }
}

class ChangeString {
  GuitarString currentString = GuitarString.firstE;

  void selectNext() {
    currentString = currentString.getNext();
  }

  TuningStatus checkTuning(double detectedFrequency) {
    return currentString.getTuningStatus(detectedFrequency);
  }

  String getCurrentNote() {
    return currentString.noteName;
  }

  double getTargetFrequency() {
    return currentString.frequency;
  }
}
