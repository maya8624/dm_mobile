import 'package:hive/hive.dart';

part 'business.g.dart';

@HiveType(typeId: 2)
class Business {
  @HiveField(0)
  int? businessId;

  @HiveField(1)
  String email;

  @HiveField(2)
  String name;

  @HiveField(3)
  String owner;

  @HiveField(4)
  String suburb;

  @HiveField(5)
  String mobile;

  @HiveField(6)
  String passcode;

  @HiveField(7)
  DateTime createdAt = DateTime.now().toUtc();

  @HiveField(8)
  DateTime updatedAt = DateTime.now().toUtc();

  Business({
    required this.email,
    required this.name,
    required this.owner,
    required this.suburb,
    required this.mobile,
    required this.passcode,
  });
}
