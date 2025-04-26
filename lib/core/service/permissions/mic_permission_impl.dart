import 'package:fluttertuner/core/service/permissions/mic_permission_interface.dart';
import 'package:permission_handler/permission_handler.dart';

class MicPermissionServiceImpl implements MicPermissionService {
  @override
  Future<void> requestPermission() async {
    final status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  @override
  Future<bool> hasPermission() async {
    return await Permission.microphone.isGranted;
  }
}
