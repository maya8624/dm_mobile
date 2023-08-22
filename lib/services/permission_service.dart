import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final Permission? permission = null;
  Future<bool> requestSMSPermission() async {
    const smsPermission = Permission.sms;
    final status = await smsPermission.status;

    if (status.isGranted != true) {
      final request = await smsPermission.request();
      if (request.isGranted != true) {
        return false;
      }
    }
    return true;
  }
}
