import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/message_notifier.dart';
import '../models/message/message.dart';

class CustomerModal {
  final int count = 0;
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();
  final _orderNoController = TextEditingController();

  void showRegisterForm(BuildContext ctx, int? key) {
    if (key != null) {
      var message = ctx.read<MessageNotifier>().getMessage(key);

      _mobileController.text = message.mobile;
      _nameController.text = message.name;
      _orderNoController.text = message.orderNo;
    }

    showModalBottomSheet(
      backgroundColor: Colors.grey.shade100,
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(30),
        //     topLeft: Radius.circular(30),
        //   ),
        // ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 30,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Mobile",
                // hintStyle: TextStyle(
                //   color: Colors.white,
                // ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _orderNoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Order No",
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                var message = Message(
                  mobile: _mobileController.text.trim(),
                  name: _nameController.text.trim(),
                  orderNo: _orderNoController.text.trim(),
                );

                if (key == null) {
                  context.read<MessageNotifier>().addItem(message);
                } else {
                  context.read<MessageNotifier>().updateItem(key, message);
                }

                _nameController.clear();
                _mobileController.clear();
                _orderNoController.clear();

                Navigator.of(context).pop();
              },
              child: Text(key == null ? "Add" : "Update"),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
