import 'package:tuner/features/tuner/domain/models/note_model.dart';

abstract class ITunerRepository {
  Stream<NoteModel> startTuning();
  Future<void> stopTuning();
  Future<bool> requestMicrophonePermission();
} 