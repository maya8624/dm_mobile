import 'package:dm_mobile/models/message/message.dart';
import 'package:dm_mobile/screens/business_screen.dart';
import 'package:dm_mobile/screens/verification_screen.dart';
import 'package:dm_mobile/utils/dimensions.dart';
import 'package:dm_mobile/utils/message_types.dart';
import 'package:dm_mobile/components/message/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../components/message/message_summary.dart';
import '../controllers/message_controller.dart';
import '../utils/wordings.dart';
import '../view_models/message_view.dart';
import '../components/customer/customer_register.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});
  final List<MessageView> messages = [];

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  MessageController mController = Get.find();
  @override
  void initState() {
    super.initState();
    mController.getMessages();
    mController.getSummary();
  }

  Message _onDismissed(int key, MessageController controller) {
    final message = controller.getOriginalMessage(key);
    if (message == null) {
      throw Exception("Message not found");
    }

    message.messageType = MessageTypes.completed;
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),

        backgroundColor: const Color.fromRGBO(18, 23, 50, 100),
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(18, 23, 50, 100),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // const DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: const Color.fromRGBO(18, 23, 50, 100),
              //   ),
              //   child: Text(
              //     "Drawer Header",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              SizedBox(
                height: Dimensions.height5,
              ),
              ListTile(
                leading: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(const VerificationScreen());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.business_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Edit Business",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(const BusinessScreen());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.message_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Message List",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(MessageScreen());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
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
        floatingActionButton: const CustomerRegister(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Obx(
            () {
              final summary = mController.summary.value;
              final List<MessageView> messageList =
                  mController.messages.toList();
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height10),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        Container(
                          padding: EdgeInsets.all(Dimensions.height10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(29, 39, 58, 100),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(0, 0.5),
                                  blurRadius: 0),
                            ],
                          ),
                          child: MessageSummary(summary: summary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: Dimensions.width20),
                      const Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      SizedBox(width: Dimensions.width10),
                      Text(
                        'Message List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimensions.width5),
                      padding: EdgeInsets.only(top: Dimensions.height5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius30),
                          topRight: Radius.circular(Dimensions.radius30),
                        ),
                      ),
                      child: messageList.isEmpty
                          ? const Text(
                              Wordings.noDataFound,
                              style: TextStyle(color: Colors.white),
                            )
                          : ListView.builder(
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        flex: 2,
                                        onPressed: (context) {
                                          final key = messageList[index].key;
                                          final Message message =
                                              _onDismissed(key, mController);
                                          mController.updateItem(key, message);
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.check_circle_outline,
                                        label: Wordings.labelComplete,
                                      ),
                                    ],
                                  ),
                                  child:
                                      MessageList(message: messageList[index]),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
