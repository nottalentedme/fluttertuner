import 'package:fluttertuner/core/di/di_container.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/interface/tuning_repository.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/tuning_repository_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

final di = DIContainerImpl();

void configureDependencies() {
  //? Service
  final AudioRecorderService audioRecorderService = AudioRecorderServiceImpl();
  final BufferService bufferService = BufferServiceImpl();
  final PitchDetector pitchDetector = PitchDetector();
  final PitchHandler pitchHandler = PitchHandler(InstrumentType.guitar);
  final MetronomePlayer metronomePlayer = MetronomePlayer();

  //? Service registration
  di.register<AudioRecorderService>(audioRecorderService);
  di.register<BufferService>(bufferService);
  di.register<MetronomePlayer>(metronomePlayer);

  //? Repository
  final TuningRepository tuningRepository = TuningRepositoryImpl(
    audioRecorderService,
    bufferService,
    pitchDetector,
    pitchHandler,
  );

  //? Repository registration
  di.register<TuningRepository>(tuningRepository);
}
