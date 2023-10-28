import 'package:bcrypt/bcrypt.dart';
import 'package:dm_mobile/components/common/common_text_field.dart';
import 'package:dm_mobile/models/business/business.dart';
import 'package:dm_mobile/screens/message_screen.dart';
import 'package:dm_mobile/utils/wordings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../utils/dimensions.dart';

class BusinessScreen extends StatefulWidget {
  final int? businessKey;
  const BusinessScreen({super.key, this.businessKey});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _suburbController = TextEditingController();
  final _ownerController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passcodeController = TextEditingController();
  final _confirmPasscodeController = TextEditingController();

  final _businessBox = Hive.box<Business>('businessBox');
  bool _isUpdated = false;

  Future<void> _saveBusiness() async {
    final passcode1 = _passcodeController.text;
    final passcode2 = _confirmPasscodeController.text;
    final hashPasscode = _generateHashPasscode(passcode1);

    final business = Business(
      name: _nameController.text,
      suburb: _suburbController.text,
      owner: _ownerController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      passcode: hashPasscode,
    );

    await _businessBox.add(business);
  }

  void _getBusiness() {
    final business = _businessBox.values.isEmpty ? null : _businessBox.getAt(0);
    if (business != null) {
      _isUpdated = true;
      _nameController.text = business.name;
      _suburbController.text = business.suburb;
      _ownerController.text = business.owner;
      _emailController.text = business.email;
      _mobileController.text = business.mobile;
    }
  }

  Future<void> _updateBusiness() async {
    final business = _businessBox.getAt(0);
    if (business == null) print("business not found.");

    var updatedBusiness = Business(
        email: _emailController.text,
        mobile: _mobileController.text,
        name: _nameController.text,
        owner: _ownerController.text,
        suburb: _suburbController.text,
        passcode: business!.passcode);

    await _businessBox.putAt(0, updatedBusiness);
  }

  bool _verifyPasscode() {
    final passcode = _passcodeController.text;
    final confirmPasscode = _confirmPasscodeController.text;

    if (passcode != confirmPasscode) {
      Get.snackbar(
        "passcode",
        "passcode and confirm passcode must be the same",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void _passcodeConfirmation(String confirmPasscode) {
    final passcode = _passcodeController.text;
    if (confirmPasscode.length == 4 && passcode != confirmPasscode) {
      Get.snackbar(
        "passcode",
        "passcode and confirm passcode must be the same",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _generateHashPasscode(String passcode) {
    final hashed = BCrypt.hashpw(passcode, BCrypt.gensalt());
    return hashed;
  }

  @override
  void initState() {
    super.initState();
    _getBusiness();
  }

  // @override
  // void dispose() {
  //   pinController.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Register"),
        backgroundColor: const Color.fromRGBO(18, 23, 50, 100),
      ),
      backgroundColor: const Color.fromRGBO(18, 23, 50, 100),
      body: Container(
        margin: EdgeInsets.fromLTRB(
          Dimensions.width10,
          Dimensions.height20,
          Dimensions.width10,
          Dimensions.height10,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextField(
                  hintText: "Business Name",
                  lengthLimit: 100,
                  message: "Please enter business name",
                  textEditController: _nameController,
                  fillColor: const Color.fromRGBO(29, 39, 58, 100),
                ),
                SizedBox(height: Dimensions.height15),
                CommonTextField(
                  hintText: "Suburb",
                  lengthLimit: 50,
                  message: "Please enter suburb",
                  textEditController: _suburbController,
                  fillColor: const Color.fromRGBO(29, 39, 58, 100),
                ),
                SizedBox(height: Dimensions.height15),
                CommonTextField(
                  hintText: "Owner",
                  lengthLimit: 50,
                  message: "Please enter owner",
                  textEditController: _ownerController,
                  fillColor: const Color.fromRGBO(29, 39, 58, 100),
                ),
                SizedBox(height: Dimensions.height15),
                CommonTextField(
                  hintText: "Email",
                  lengthLimit: 100,
                  message: "Please enter email",
                  textEditController: _emailController,
                  fillColor: const Color.fromRGBO(29, 39, 58, 100),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: Dimensions.height15),
                CommonTextField(
                  hintText: "Mobile",
                  lengthLimit: 15,
                  message: "Please enter mobile",
                  textEditController: _mobileController,
                  fillColor: const Color.fromRGBO(29, 39, 58, 100),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: Dimensions.height15),
                Visibility(
                  visible: _isUpdated ? false : true,
                  child: CommonTextField(
                    hintText: "Passcode (4 digit numbers)",
                    lengthLimit: 4,
                    message: "Please enter passcode",
                    textEditController: _passcodeController,
                    fillColor: const Color.fromRGBO(29, 39, 58, 100),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: Dimensions.height15),
                Visibility(
                  visible: _isUpdated ? false : true,
                  child: CommonTextField(
                    hintText: "Confirm Passcod",
                    lengthLimit: 4,
                    message: "Please enter confirm passcode",
                    textEditController: _confirmPasscodeController,
                    fillColor: const Color.fromRGBO(29, 39, 58, 100),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    onChanged: (String value) {
                      //OR showDialog instead of snackbar
                      _passcodeConfirmation(value);
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height15),
                SizedBox(
                  height: Dimensions.height60,
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                    onPressed: () {
                      final passcodeVerified = _verifyPasscode();
                      if (passcodeVerified == false) return;

                      if (_formKey.currentState!.validate()) {
                        _isUpdated ? _updateBusiness() : _saveBusiness();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data saved!!!"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      _isUpdated ? Wordings.update : Wordings.register,
                      style: TextStyle(
                        fontSize: Dimensions.font18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
