import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/customer/customer.dart';
import '../models/message/message.dart';
import '../utils/message_types.dart';
import '../view_models/message_view.dart';
import '../view_models/summary_view.dart';

class MessageController extends GetxController {
  final Box<Message> boxMessages = Hive.box<Message>("messageBox");
  int get length => boxMessages.length;

  RxList<MessageView> _messages = <MessageView>[].obs;
  RxList<MessageView> get messages => _messages.reversed.toList().obs;

  Rx<SummaryView> _summary =
      SummaryView(prepTotal: 0, sentTotal: 0, completedTotal: 0, grandTotal: 0)
          .obs;

  Rx<SummaryView> get summary => _summary.obs.value;

  Future<void> addItem(Message item) async {
    final key = await boxMessages.add(item);
    final message = getMessage(key);
    _messages.add(message);
    getSummary();
  }

  Future<void> deleteItem(int key) async {
    // final message = getMessage(key);
    _messages.removeWhere((element) => element.key == key);
    await boxMessages.delete(key);
    getSummary();
  }

  Future<void> updateItem(int key, Message updatedMessage) async {
    await boxMessages.put(key, updatedMessage);

    if (updatedMessage.messageType == MessageTypes.completed) {
      _messages.removeWhere((element) => element.key == key);
    } else {
      final message = getMessage(key);
      final index = _messages.indexWhere((element) => element.key == key);
      _messages[index] = message;
    }

    getSummary();
  }

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

  void getMessages() {
    final data = boxMessages.keys.map((key) {
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

    var messages = data
        .where((element) => element.messageType != MessageTypes.completed)
        .toList();

    _messages = RxList<MessageView>.from(messages);
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

  void getSummary() {
    final messages = boxMessages.values;
    final prepTotal =
        messages.where((x) => x.messageType == MessageTypes.prep).length;

    final sentTotal =
        messages.where((x) => x.messageType == MessageTypes.sent).length;

    final completedTotal =
        messages.where((x) => x.messageType == MessageTypes.completed).length;

    final grandTotal = messages.length;

    final result = SummaryView(
        prepTotal: prepTotal,
        sentTotal: sentTotal,
        completedTotal: completedTotal,
        grandTotal: grandTotal);

    _summary = Rx<SummaryView>(result);
  }
}
