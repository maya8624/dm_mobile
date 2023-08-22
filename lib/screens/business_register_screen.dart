import 'package:bcrypt/bcrypt.dart';
import 'package:dm_mobile/models/business/business.dart';
import 'package:dm_mobile/screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BusinessRegisterScreen extends StatefulWidget {
  final int? businessKey;
  const BusinessRegisterScreen({super.key, this.businessKey});

  @override
  State<BusinessRegisterScreen> createState() => _BusinessRegisterScreenState();
}

class _BusinessRegisterScreenState extends State<BusinessRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _suburbController = TextEditingController();
  final _ownerController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passcodeController = TextEditingController();
  final _confirmPasscodeController = TextEditingController();

  final _businessBox = Hive.box<Business>('businessBox');

  Future<void> _saveBusiness() async {
    final passcode1 = _passcodeController.text;
    final passcode2 = _confirmPasscodeController.text;
    _verifyPasscode(passcode1, passcode2);

    final hashpasscode = _generateHashPasscode(passcode1);
    var business = Business(
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
    var business = _businessBox.values.isEmpty ? null : _businessBox.getAt(0);
    if (business != null) {
      _nameController.text = business.name;
      _suburbController.text = business.suburb;
      _ownerController.text = business.owner;
      _emailController.text = business.email;
    }
  }

  Future<void> _updateBusiness(int key, Business business) async {
    await _businessBox.put(key, business);
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
    var passcode = _passcodeController.text;
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
      backgroundColor: Color.fromRGBO(18, 23, 50, 100),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                        borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
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
                        borderRadius: BorderRadius.circular(10),
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
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 100,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Mobile",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _passcodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter passcode';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Passcode (4 digit numbers)",
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(29, 39, 58, 100)),
                ),
                TextFormField(
                  controller: _confirmPasscodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm passcode';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _saveBusiness();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data saved!!!"),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
