import 'package:dm_mobile/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/message_notifier.dart';
import '../widgets/customer_register.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    final _count = Provider.of<MessageNotifier>(context).length;

    return Scaffold(
      backgroundColor: Colors.black,
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
                      color: Colors.grey.shade900,
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
                              "2",
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
                              "3",
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
                              "1",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Deleted",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "1",
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
                              "5",
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
                  color: Colors.black,
                ),
                child: _count <= 0
                    ? const Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.white),
                      )
                    : ListView.builder(
                        itemCount:
                            _count, // context.watch<CustomerNotifier>().length,
                        itemBuilder: (context, index) {
                          var messages =
                              // Provider.of<CustomerNotifier>(context).getMessages();
                              context.watch<MessageNotifier>().getMessages();

                          return MessageList(message: messages[index]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
