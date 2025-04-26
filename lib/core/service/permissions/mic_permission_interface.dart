import 'package:fluttertuner/feature/config/dependency.dart';

abstract interface class MicPermissionService extends Service {
  Future<void> requestPermission();
  Future<bool> hasPermission();
}
