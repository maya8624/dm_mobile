import 'package:hive/hive.dart';

import '../models/business/business.dart';

class BusinessController {
  final Box<Business> boxBusiness = Hive.box<Business>("businessBox");

  Business? getBusiness() {
    if (boxBusiness.isEmpty) return null;
    final shop = boxBusiness.getAt(0);
    return shop;
  }

  void sendBusiness() {}
}
