import 'package:cron/cron.dart';
import 'package:dm_mobile/services/http_service.dart';
import 'package:get/get.dart';

import '../controllers/message_controller.dart';
import '../utils/constants.dart';

class CronService {
  void startScheduler() {
    final cron = Cron();
    cron.schedule(Schedule.parse('*/10 * * * *'), () async {
      // await customerSchedule();
      print('every 10 minutes');
    });
  }

  Future<void> customerSchedule() async {
    var jsonString = Get.find<MessageController>().getCustomers();
    var httpService =
        HttpService(endpoint: customerServiceBus, body: jsonString);
    await httpService.post();
  }
}
