import 'package:fluttertuner/core/di/dependency.dart';

abstract interface class MetronomeTickerRepository extends Repository {
  void start();

  void stop();

  void dispose();
}
