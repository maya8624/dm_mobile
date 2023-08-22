import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/message_notifier.dart';
import '../models/message/message.dart';
import '../utils/message_types.dart';

class CustomerModal {
  final int count = 0;
  final _formKey = GlobalKey<FormState>();
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
      // backgroundColor: Color.fromARGB(255, 6, 6, 10),
      backgroundColor: Colors.black,
      // backgroundColor: const Color.fromRGBO(29, 39, 58, 100),
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
          left: 20,
          right: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _mobileController,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorStyle: const TextStyle(color: Colors.white),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Mobile",
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color.fromARGB(255, 80, 79, 79),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorStyle: const TextStyle(color: Colors.white),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Name",
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 80, 79, 79),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _orderNoController,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorStyle: const TextStyle(color: Colors.white),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Order No",
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 80, 79, 79),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order no number';
                  }
                },
              ),
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() == false) {
                        return;
                      }

                      var message = Message(
                        messageType: MessageTypes.prep,
                        mobile: _mobileController.text.trim(),
                        name: _nameController.text.trim(),
                        orderNo: _orderNoController.text.trim(),
                      );

                      if (key == null) {
                        context.read<MessageNotifier>().addItem(message);
                      } else {
                        context
                            .read<MessageNotifier>()
                            .updateItem(key, message);
                      }

                      _nameController.clear();
                      _mobileController.clear();
                      _orderNoController.clear();

                      Navigator.of(context).pop();
                    },
                    child: Text(key == null ? "Add" : "Update"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
