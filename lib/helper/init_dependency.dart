import 'package:get/get.dart';

import '../controllers/message_controller.dart';

class InitDep implements Bindings {
  @override
  void dependencies() {
    Get.put(MessageController());
    // Get.put(BusinessController());
  }
}
