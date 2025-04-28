import 'package:fluttertuner/core/service/permissions/mic_permission_impl.dart';
import 'package:fluttertuner/core/service/permissions/mic_permission_interface.dart';
import 'package:fluttertuner/feature/config/di_container.dart';
import 'package:fluttertuner/feature/metronome/services/metronome_player.dart';
import 'package:fluttertuner/feature/tuner/data/repository/tuner_repository_impl.dart';
import 'package:fluttertuner/feature/tuner/domain/repository/tuner_repository.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_impl.dart';
import 'package:fluttertuner/feature/tuner/service/buffer/buffer_service_interface.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_impl_service.dart';
import 'package:fluttertuner/feature/tuner/service/recorder/tuner_audio_interface_service.dart';
import 'package:fluttertuner/feature/tunings/data/repository/tuning_repository_impl.dart';
import 'package:fluttertuner/feature/tunings/domain/repository/tuning_repository.dart';
import 'package:fluttertuner/feature/tunings/service/tuning_storage/tuning_storage.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

final di = DIContainerImpl();

void configureDependencies() {
  //? Service
  final MicPermissionService micPermissionService = MicPermissionServiceImpl();
  final AudioRecorderService audioRecorderService =
      AudioRecorderServiceImpl(micPermissionService);
  final BufferService bufferService = BufferServiceImpl();
  final PitchDetector pitchDetector = PitchDetector();
  final PitchHandler pitchHandler = PitchHandler(InstrumentType.guitar);
  final MetronomePlayer metronomePlayer = MetronomePlayer();
  final TuningStorage tuningStorage = TuningStorage();

  //? Service registration
  di.register<MicPermissionService>(micPermissionService);
  di.register<AudioRecorderService>(audioRecorderService);
  di.register<BufferService>(bufferService);
  di.register<MetronomePlayer>(metronomePlayer);

  //? Repository
  final TuningRepository tuningRepository = TuningRepositoryImpl(tuningStorage);
  final TunerRepository tunerRepository = TunerRepositoryImpl(
    audioRecorderService,
    bufferService,
    pitchDetector,
    pitchHandler,
    tuningRepository,
  );

  //? Repository registration
  di.register<TuningRepository>(tuningRepository);
  di.register<TunerRepository>(tunerRepository);
}
