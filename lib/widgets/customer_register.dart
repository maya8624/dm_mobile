import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/message_notifier.dart';
import '../models/message/message.dart';
import 'customer_modal.dart';

class CustomRegisterModal extends StatefulWidget {
  const CustomRegisterModal({
    super.key,
  });

  @override
  State<CustomRegisterModal> createState() => _CustomRegisterModalState();
}

class _CustomRegisterModalState extends State<CustomRegisterModal> {
  @override
  void initState() {
    super.initState();
  }

  // final _mobileController = TextEditingController();
  // final _nameController = TextEditingController();
  // final _orderNoController = TextEditingController();

  // // _addItem(Message message) {
  // //   _messageBox.add(message);
  // // }

  // void showRegisterForm(BuildContext ctx, int? key) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.grey.shade100,
  //     context: ctx,
  //     elevation: 5,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(30),
  //       ),
  //     ),
  //     builder: (_) => Container(
  //       // decoration: BoxDecoration(
  //       //   borderRadius: BorderRadius.only(
  //       //     topRight: Radius.circular(30),
  //       //     topLeft: Radius.circular(30),
  //       //   ),
  //       // ),
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //         top: 30,
  //         left: 30,
  //         right: 30,
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           TextField(
  //             controller: _mobileController,
  //             keyboardType: TextInputType.number,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               hintText: "Mobile",
  //               // hintStyle: TextStyle(
  //               //   color: Colors.white,
  //               // ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           TextField(
  //             controller: _nameController,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               hintText: "Name",
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           TextField(
  //             controller: _orderNoController,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               hintText: "Order No",
  //             ),
  //           ),
  //           const SizedBox(height: 15),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               backgroundColor: Colors.green,
  //             ),
  //             onPressed: () {
  //               var message = Message(
  //                 mobile: _mobileController.text.trim(),
  //                 name: _nameController.text.trim(),
  //                 orderNo: _orderNoController.text.trim(),
  //               );

  //               if (key == null) {
  //                 context.read<CustomerNotifier>().addItem(message);
  //               } else {
  //                 context.read<CustomerNotifier>().updateItem(key, message);
  //               }

  //               _nameController.clear();
  //               _mobileController.clear();
  //               _orderNoController.clear();

  //               Navigator.of(ctx).pop();
  //             },
  //             child: Text(key == null ? "Add" : "Update"),
  //           ),
  //           const SizedBox(height: 10),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final CustomerModal modal = CustomerModal();
    return FloatingActionButton(
      onPressed: () => modal.showRegisterForm(context, null),
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
