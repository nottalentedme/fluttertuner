import 'package:fluttertuner/core/di/dependency.dart';
import 'package:fluttertuner/core/di/di_container_interface.dart';

class DIContainerImpl implements DIContainer {
  final Map<Type, Dependency> _deps = {};

  @override
  void register<T extends Dependency>(T dep) {
    _deps[T] = dep;
  }

  @override
  T get<T extends Dependency>() {
    final dep = _deps[T];
    if (dep == null) {
      throw Exception('Dependency not found $T');
    }
    return dep as T;
  }
}
