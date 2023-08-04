import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/message/message.dart';

class MessageNotifier extends ChangeNotifier {
  final Box<Message> boxMessages = Hive.box<Message>("messageBox");
  int get length => boxMessages.length;

  Future<void> addItem(Message item) async {
    await boxMessages.add(item);
    notifyListeners();
  }

  Future<void> deleteItem(int key) async {
    await boxMessages.delete(key);
    notifyListeners();
  }

  Future<void> updateItem(int key, Message item) async {
    await boxMessages.put(key, item);
    notifyListeners();
  }

  MessageView getMessage(int key) {
    var message = boxMessages.getAt(key);
    return MessageView(
      key: key,
      messageType: message!.messageType,
      mobile: message.mobile,
      name: message.name,
      orderNo: message.orderNo,
      createdAt: message.createdAt,
      updatedAt: message.updatedAt,
    );
  }

  //TODO:
  List<MessageView> getMessages() {
    final messages = boxMessages.keys.map((key) {
      final message = boxMessages.get(key);
      return MessageView(
          key: key,
          messageType: message!.messageType,
          mobile: message.mobile,
          name: message.name,
          orderNo: message.orderNo,
          createdAt: message.createdAt,
          updatedAt: message.updatedAt);
    });

    return messages.toList().reversed.toList();
  }
}

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
