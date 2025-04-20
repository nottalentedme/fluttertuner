import 'package:fluttertuner/feature/config/dependency.dart';

abstract interface class MetronomeTickerRepository extends Repository {
  void start();

  void stop();

  void dispose();
}
