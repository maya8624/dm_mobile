import 'package:hive/hive.dart';

part 'shop.g.dart';

@HiveType(typeId: 2)
class Shop {
  @HiveField(0)
  int? shopId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String suburb;

  @HiveField(3)
  String owner;

  @HiveField(4)
  String email;

  @HiveField(5)
  String pin;

  @HiveField(6)
  DateTime createdAt = DateTime.now().toUtc();

  @HiveField(7)
  DateTime updatedAt = DateTime.now().toUtc();

  Shop({
    // required this.shopId,
    required this.name,
    required this.suburb,
    required this.owner,
    required this.email,
    required this.pin,
  });
}
