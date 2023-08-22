import 'package:dm_mobile/models/message/message.dart';
import 'package:dm_mobile/utils/message_types.dart';
import 'package:dm_mobile/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/message_notifier.dart';
import '../view_models/summary_view.dart';
import '../widgets/customer_register.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    var summary = Provider.of<MessageNotifier>(context).getSummary();
    var messages = Provider.of<MessageNotifier>(context).getMessages();
    final count = messages.length;

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
      floatingActionButton: CustomRegisterModal(),
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
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Icon(
                                  Icons.restart_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Prep",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              summary.prepTotal.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[600],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Icon(
                                  Icons.mark_chat_read_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Sent",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              summary.sentTotal.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Icon(
                                  Icons.task_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Completed",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              summary.completedTotal.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 7, 161, 167),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Total",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              summary.grandTotal.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // SizedBox(height: 5),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(width: 20),
            //     Icon(
            //       Icons.list,
            //       color: Colors.white,
            //     ),
            //     SizedBox(width: 10),
            //     Text(
            //       'Message List',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(width: 10),
            //     Icon(
            //       Icons.arrow_upward,
            //       color: Colors.white,
            //       size: 20,
            //     ),
            //   ],
            // ),
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
                                          .read<MessageNotifier>()
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
    final message = MessageNotifier().getOriginalMessage(key);
    if (message == null) {
      throw Exception("Message not found");
    }

    message.messageType = MessageTypes.completed;
    return message;
  }
}
