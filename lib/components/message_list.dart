import 'package:dm_mobile/components/texts/medium_text.dart';
import 'package:dm_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/sms_service.dart';
import '../providers/message_provider.dart';
import '../utils/message_types.dart';
import '../utils/wordings.dart';
import '../view_models/message_view.dart';
import 'customer_modal.dart';

class MessageList extends StatefulWidget {
  final MessageView message;

  const MessageList({
    super.key,
    required this.message,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
//TODO: refactor - combine the three methods into one
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

  String _getStatusWording(int messageType) {
    switch (messageType) {
      case MessageTypes.prep:
        return Wordings.prep;
      case MessageTypes.sent:
        return Wordings.sent;
      case MessageTypes.completed:
        return Wordings.completed;
      default:
        return Wordings.error;
    }
  }

  Future<void> _textCustomer(String mobile) async {
    final smsController = SMSService();
    final List<String> recipients = <String>[mobile];
    final result = await smsController.sendSms("new message!!", recipients);
    print(result);
  }

  Future<void> _updateMessageType(MessageView messageView) async {
    final messageNotifier = MessageProvider();
    final message = messageNotifier.getOriginalMessage(messageView.key);
    if (message == null) {
      throw Exception("Message not found");
    }

    message.messageType = MessageTypes.sent;
    message.updatedAt = DateTime.now().toUtc();
    await messageNotifier.updateItem(messageView.key, message);
  }

  @override
  Widget build(BuildContext context) {
    final CustomerModal modal = CustomerModal();

// body: _isFirstLoadRunning
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Container(
        padding: EdgeInsets.all(Dimensions.width15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0, 0),
              blurRadius: 0,
            ),
          ],
          color: const Color.fromRGBO(29, 39, 58, 100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _getStatusColor(widget.message.messageType),
              ),
              child: Icon(
                _getStatusIcon(widget.message.messageType),
                color: Colors.white,
                size: 40,
              ),
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
                        widget.message.key,
                      );
                    },
                    child: MediumText(
                      text: "${widget.message.mobile} ${widget.message.name}",
                      size: Dimensions.font18,
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  Text(
                    "${Wordings.orderNo} : ${widget.message.orderNo}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  Row(
                    children: [
                      MediumText(
                        text: _getStatusWording(widget.message.messageType),
                        size: Dimensions.font16,
                      ),
                      SizedBox(width: Dimensions.width5),
                      MediumText(
                        text: DateFormat.jms()
                            .format(widget.message.createdAt.toLocal()),
                        size: Dimensions.font16,
                        color: _getStatusColor(widget.message.messageType),
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 0),
            Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  tooltip: "Send sms",
                  alignment: Alignment.topCenter,
                  constraints: BoxConstraints(maxHeight: 35),
                  icon: const Icon(
                    Icons.sms,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Are you sure you want to send sms?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await _textCustomer(widget.message.mobile);
                                await _updateMessageType(widget.message);
                                setState(() {
                                  widget.message.messageType =
                                      MessageTypes.sent;
                                });
                              },
                              child: const Text("Ok")),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel")),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  constraints: BoxConstraints(maxHeight: 30),
                  icon: const Icon(
                    Icons.vibration,
                    color: Colors.white,
                  ),
                  tooltip: "Call customer",
                  onPressed: () async {
                    //TODO: implementd call customer
                    // await _textCustomer(message.mobile);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
