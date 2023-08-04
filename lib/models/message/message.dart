import 'package:dm_mobile/utils/message_types.dart';
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class Message {
  @HiveField(0)
  int messageType = MessageTypes.prep;

  @HiveField(1)
  String mobile;

  @HiveField(2)
  String name;

  @HiveField(3)
  String orderNo;

  @HiveField(4)
  DateTime createdAt = DateTime.now().toUtc();

  @HiveField(5)
  DateTime updatedAt = DateTime.now().toUtc();

  Message({
    required this.mobile,
    required this.name,
    required this.orderNo,
  });
}
