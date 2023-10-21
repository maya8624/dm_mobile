import 'package:dm_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/message_controller.dart';
import '../../models/message/message.dart';
import '../../utils/message_types.dart';
import 'customer_text_field.dart';

class CustomerModal {
  final int count = 0;
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();
  final _orderNoController = TextEditingController();
  MessageController controller = Get.find();

  void showRegisterForm(BuildContext ctx, int? key) {
    if (key != null) {
      var message = controller.getMessage(key);

      _mobileController.text = message.mobile;
      _nameController.text = message.name;
      _orderNoController.text = message.orderNo;
    }

    showModalBottomSheet(
      backgroundColor: Colors.black,
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
          left: 20,
          right: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomerTextField(
                hintText: "Mobile",
                message: "Please enter mobile number",
                lengthLimit: 15,
                textEditController: _mobileController,
              ),
              SizedBox(height: Dimensions.height10),
              CustomerTextField(
                hintText: "Name",
                message: "Please enter name",
                lengthLimit: 30,
                textEditController: _nameController,
              ),
              SizedBox(height: Dimensions.height10),
              CustomerTextField(
                hintText: "Order No",
                message: "PPlease enter order number",
                lengthLimit: 10,
                textEditController: _orderNoController,
              ),
              SizedBox(height: Dimensions.height15),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius10,
                        ),
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
                        controller.addItem(message);
                      } else {
                        controller.updateItem(key, message);
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
