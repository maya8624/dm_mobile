import 'dart:io';

import 'package:dm_mobile/services/permission_service.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SMSService {
  Future<String> sendSms(String message, List<String> recipients) async {
    final sendDirect = Platform.isAndroid ? true : false;
    String result;

    if (sendDirect == true) {
      final permission = await PermissionService().requestSMSPermission();
      if (permission != true) {
        return "SMS permission is not granted";
      }
    }

    try {
      result = await sendSMS(
          message: message, recipients: recipients, sendDirect: sendDirect);
    } catch (e) {
      result = "SMS failed to send";
    }
    return result;
  }

  Future<bool> canSendSms() async {
    bool result = await canSendSMS();
    // result ? 'This unit can send SMS' : 'This unit cannot send SMS';
    return result;
  }
}
