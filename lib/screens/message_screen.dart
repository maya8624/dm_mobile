import 'package:dm_mobile/models/message/message.dart';
import 'package:dm_mobile/utils/message_types.dart';
import 'package:dm_mobile/components/message_list.dart';
import 'package:dm_mobile/utils/wordings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../components/messages/summary_top.dart';
import '../providers/message_provider.dart';
import '../view_models/message_view.dart';
import 'customer_add_screen.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});
  List<MessageView> messages = [];

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = MessageProvider();
    final messages = provider.getMessages();
    final summary = provider.getSummary();
    final count = messages.length;

    context.watch<MessageView>();
    // final provider = context.watch<MessageProvider>();
    // final summary = provider.getSummary();
    // final messages = provider.getMessages();
    // final count = messages.length;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 23, 50, 100),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blue[800],
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //           color: Colors.white,
      //         ),
      //         label: 'home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.add,
      //           color: Colors.white,
      //         ),
      //         label: 'Order'),
      // BottomNavigationBarItem(
      //     icon: Icon(
      //       Icons.person,
      //       color: Colors.white,
      //     ),
      //     label: 'User',
      // ),
      // ],
      // ),
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      // title: const Text("SMS List"),
      // ),
      floatingActionButton: CustomerAddScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    '23 Jan, 2021',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(29, 39, 58, 100),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(0, 0.5),
                            blurRadius: 0),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SummaryTop(
                          containerColor: Colors.green,
                          icon: Icons.restart_alt_outlined,
                          total: summary.prepTotal,
                          wording: Wordings.prep,
                        ),
                        SummaryTop(
                          containerColor: Colors.orange.shade600,
                          icon: Icons.mark_chat_read_outlined,
                          total: summary.sentTotal,
                          wording: Wordings.sent,
                        ),
                        SummaryTop(
                          containerColor: Colors.redAccent,
                          icon: Icons.task_alt_outlined,
                          total: summary.completedTotal,
                          wording: Wordings.completed,
                        ),
                        SummaryTop(
                          containerColor:
                              const Color.fromARGB(255, 7, 161, 167),
                          icon: Icons.add_circle_outline,
                          total: summary.grandTotal,
                          wording: Wordings.total,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Message List',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: count <= 0
                    ? const Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.white),
                      )
                    : ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 2,
                                    onPressed: (context) {
                                      final key = messages[index].key;
                                      final Message message = _onDismissed(key);
                                      context
                                          .read<MessageProvider>()
                                          .updateItem(key, message);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.check_circle_outline,
                                    label: 'Complete',
                                  ),
                                ],
                              ),
                              child: MessageList(message: messages[index]));
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Message _onDismissed(int key) {
    final message = MessageProvider().getOriginalMessage(key);
    if (message == null) {
      throw Exception("Message not found");
    }

    message.messageType = MessageTypes.completed;
    return message;
  }
}
