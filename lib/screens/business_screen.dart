import 'package:bcrypt/bcrypt.dart';
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
    _verifyPasscode(passcode1, passcode2);

    final hashpasscode = _generateHashPasscode(passcode1);
    final business = Business(
      name: _nameController.text,
      suburb: _suburbController.text,
      owner: _ownerController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      passcode: hashpasscode,
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

  void _verifyPasscode(String passcode1, String passcode2) {
    if (passcode1 != passcode2) {
      Get.snackbar(
        "passcode",
        "passcode and confirm passcode must be the same",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
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
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter business name';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 100,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius10,
                        ),
                      ),
                      hintText: "Business Name",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _suburbController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter suburb';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      hintText: "Suburb",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _ownerController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter owner';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      hintText: "Owner",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 100,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius10,
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius10,
                        ),
                      ),
                      hintText: "Mobile",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                Visibility(
                  visible: _isUpdated ? false : true,
                  child: TextFormField(
                    controller: _passcodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter passcode';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                        ),
                        hintText: "Passcode (4 digit numbers)",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                  ),
                ),
                Visibility(
                  visible: _isUpdated ? false : true,
                  child: TextFormField(
                    controller: _confirmPasscodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm passcode';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius10,
                          ),
                        ),
                        hintText: "Confirm Passcode",
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                    onChanged: (String value) {
                      //OR showDialog instead of snackbar
                      _passcodeConfirmation(value);
                    },
                  ),
                ),
                SizedBox(height: Dimensions.height20),
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
