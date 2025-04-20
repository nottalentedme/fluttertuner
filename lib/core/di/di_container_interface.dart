import 'package:fluttertuner/core/di/dependency.dart';

abstract interface class DIContainer {
  void register<T extends Dependency>(T instance);

  T get<T extends Dependency>();
}
