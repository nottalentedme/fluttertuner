abstract class TunerEvent {
  const TunerEvent();
}

class StartTuning extends TunerEvent {
  const StartTuning();
}

class StopTuning extends TunerEvent {
  const StopTuning();
} 