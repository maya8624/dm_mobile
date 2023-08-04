import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/message/message.dart';
import '../providers/message_notifier.dart';
import '../utils/message_types.dart';
import 'customer_modal.dart';
import 'customer_register.dart';

class MessageList extends StatelessWidget {
  final MessageView message;

  const MessageList({
    super.key,
    required this.message,
  });

  IconData _getStatusIcon(int messageType) {
    switch (messageType) {
      case MessageTypes.prep:
        return Icons.restart_alt_outlined;
      case MessageTypes.sent:
        return Icons.mark_chat_read_outlined;
      case MessageTypes.completed:
        return Icons.task_alt_outlined;
      case MessageTypes.deleted:
        return Icons.delete_forever_outlined;
      default:
        return Icons.error_outline;
    }
  }

  Color _getStatusColor(int messageType) {
    switch (messageType) {
      case MessageTypes.prep:
        return Colors.green;
      case MessageTypes.sent:
        return Colors.orange;
      case MessageTypes.completed:
        return Colors.red;
      case MessageTypes.deleted:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomerModal modal = CustomerModal();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        // height: 90,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0, 0),
              blurRadius: 0,
            ),
          ],
          color: Colors.grey.shade900,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: _getStatusColor(message.messageType),
                  ),
                  child: Icon(
                    _getStatusIcon(message.messageType),
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      modal.showRegisterForm(
                        context,
                        message.key,
                      );
                    },
                    child: Text(
                      "${message.mobile} ${message.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Order No: ${message.orderNo}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Text(
                        "Prep:",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        DateFormat.jms().format(message.createdAt.toLocal()),
                        style: TextStyle(
                          fontSize: 14,
                          color: _getStatusColor(message.messageType),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Column(
              children: const [
                Icon(
                  Icons.sms,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Icon(
                  Icons.vibration,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
