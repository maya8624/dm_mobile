import 'package:flutter/material.dart';

import '../components/common/common_text_field.dart';
import '../components/text/medium_text.dart';
import '../utils/dimensions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChecked = false;
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromRGBO(18, 23, 50, 100),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      backgroundColor: Color.fromRGBO(18, 23, 50, 100),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            Dimensions.width10,
            Dimensions.height20,
            Dimensions.width10,
            Dimensions.height10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediumText(
                text: "PREFERENCES",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: Dimensions.height15),
              TextButton(
                onPressed: () {},
                child: MediumText(
                  text: "SMS Message",
                ),
              ),
              SizedBox(height: Dimensions.height15),
              TextButton(
                onPressed: () {},
                child: MediumText(
                  text: "Change Passcode",
                ),
              ),
              // CommonTextField(
              //   hintText: "Default message(up to 30 characters)",
              //   lengthLimit: 30,
              //   message: "Please enter message",
              //   textEditController: _messageController,
              //   fillColor: const Color.fromRGBO(29, 39, 58, 100),
              // ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
