import 'dart:io';

import 'package:flutter_sms/flutter_sms.dart';

class SMSController {
  //TODO: if the device Android, sendDirect = true
  Future<String> sendSms(String message, List<String> recipients) async {
    var sendDirect = Platform.isAndroid ? true : false;
    String result;

    try {
      result = await sendSMS(
          message: message, recipients: recipients, sendDirect: sendDirect);
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<bool> canSendSms() async {
    bool result = await canSendSMS();
    // result ? 'This unit can send SMS' : 'This unit cannot send SMS';
    return result;
  }
}
