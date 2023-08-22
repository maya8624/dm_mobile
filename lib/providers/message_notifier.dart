import 'dart:convert';

import 'package:dm_mobile/view_models/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/customer.dart';
import '../models/message/message.dart';
import '../utils/message_types.dart';
import '../view_models/messaage_view.dart';

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

  //  Future<void> updateMessageStatus(int key, MessageTypes types) async {

  //   await boxMessages.put(key, item);
  //   notifyListeners();
  // }

  MessageView getMessage(int key) {
    final message = boxMessages.getAt(key);
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

  Message? getOriginalMessage(int key) {
    var message = boxMessages.getAt(key);
    return message;
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
    return messages
        .where((element) => element.messageType != MessageTypes.completed)
        .toList()
        .reversed
        .toList();
  }

  String getCustomers() {
    final customers = boxMessages.values.map((message) {
      return Customer(
        name: message.name,
        mobile: message.mobile,
        orderNo: message.orderNo,
      );
    });

    final jsonString = json.encode(customers);
    return jsonString;
  }

  SummaryView getSummary() {
    final messages = boxMessages.values;
    final prepTotal =
        messages.where((x) => x.messageType == MessageTypes.prep).length;

    final sentTotal =
        messages.where((x) => x.messageType == MessageTypes.sent).length;

    final completedTotal =
        messages.where((x) => x.messageType == MessageTypes.completed).length;

    final grandTotal = messages.length;

    final summary = SummaryView(
        prepTotal: prepTotal,
        sentTotal: sentTotal,
        completedTotal: completedTotal,
        grandTotal: grandTotal);

    return summary;
  }
}
