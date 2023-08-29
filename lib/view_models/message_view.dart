class MessageView {
  int key;
  int messageType;
  String mobile;
  String name;
  String orderNo;
  DateTime createdAt;
  DateTime updatedAt;

  MessageView({
    required this.key,
    required this.messageType,
    required this.mobile,
    required this.name,
    required this.orderNo,
    required this.createdAt,
    required this.updatedAt,
  });
}
