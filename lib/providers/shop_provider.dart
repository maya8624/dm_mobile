import 'package:hive/hive.dart';

import '../models/shop/shop.dart';

class ShopProvider {
  final Box<Shop> boxShops = Hive.box<Shop>("shopBox");

  Shop? getShop() {
    if (boxShops.isEmpty) return null;
    final shop = boxShops.getAt(0);
    return shop;
  }
}
