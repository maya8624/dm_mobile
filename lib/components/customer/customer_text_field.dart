import 'package:dm_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerTextField extends StatelessWidget {
  final String hintText;
  final int lengthLimit;
  final String message;
  final TextEditingController textEditController;

  const CustomerTextField({
    super.key,
    required this.hintText,
    required this.lengthLimit,
    required this.message,
    required this.textEditController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditController,
      style: const TextStyle(color: Colors.white),
      inputFormatters: [LengthLimitingTextInputFormatter(lengthLimit)],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
        ),
        errorStyle: const TextStyle(color: Colors.white),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(255, 80, 79, 79),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return message;
        }
        return null;
      },
    );
  }
}
