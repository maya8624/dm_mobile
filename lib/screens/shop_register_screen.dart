import 'package:bcrypt/bcrypt.dart';
import 'package:dm_mobile/models/shop/shop.dart';
import 'package:dm_mobile/screens/message_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pinput/pinput.dart';

class ShopRegisterScreen extends StatefulWidget {
  final int? shopKey;
  const ShopRegisterScreen({super.key, this.shopKey});

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _suburbController = TextEditingController();
  final _ownerController = TextEditingController();
  final _emailController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final _pin1Controller = TextEditingController();
  final _pin2Controller = TextEditingController();

  final _shopBox = Hive.box<Shop>('shopBox');

  Future<void> _saveShop() async {
    final pin1 = _pin1Controller.text;
    final pin2 = _pin2Controller.text;
    _verifyPin(pin1, pin2);

    final hashPin = _generateHashPin(pin1);
    var shop = Shop(
      name: _nameController.text,
      suburb: _suburbController.text,
      owner: _ownerController.text,
      email: _emailController.text,
      pin: hashPin,
    );

    await _shopBox.add(shop);
  }

  void _getShop() {
    var shop = _shopBox.values.isEmpty ? null : _shopBox.getAt(0);
    if (shop != null) {
      _nameController.text = shop.name;
      _suburbController.text = shop.suburb;
      _ownerController.text = shop.owner;
      _emailController.text = shop.email;
      _pinController.text = shop.pin;
    }
  }

  Future<void> _updateShop(int key, Shop shop) async {
    await _shopBox.put(key, shop);
  }

  void _verifyPin(String pin1, String pin2) {
    if (pin1 != pin2) {
      Get.snackbar(
        "pin",
        "pin and confirm pin must be the same",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _pinConfirmation(String confirmPin) {
    var pin = _pinController.text;
    if (confirmPin.length == 4 && pin != confirmPin) {
      Get.snackbar(
        "pin",
        "pin and confirm pin must be the same",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _generateHashPin(String pin) {
    final hashed = BCrypt.hashpw(pin, BCrypt.gensalt());
    return hashed;
  }

  @override
  void initState() {
    super.initState();
    _getShop();
  }

  // @override
  // void dispose() {
  //   pinController.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Register"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter shop name';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Shop Name",
                  ),
                ),
                TextFormField(
                  controller: _suburbController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter suburb';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Suburb",
                  ),
                ),
                TextFormField(
                  controller: _ownerController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter owner';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Owner",
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Email",
                  ),
                ),
                // TextFormField(
                //   controller: _pinController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter pin';
                //     }
                //   },
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     hintText: "Pin",
                //   ),
                // ),
                // TextFormField(
                //   controller: _confirmPinController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter pin';
                //     }
                //   },
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     hintText: "Confirm pin",
                //   ),
                //   onChanged: (String value) {
                //     //OR showDialog instead of snackbar
                //     _pinConfirmation(value);
                //   },
                // ),
                Pinput(
                  length: 4,
                  controller: _pin1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pin';
                    }
                  },
                ),
                SizedBox(height: 5),
                Pinput(
                  length: 4,
                  controller: _pin2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm pin';
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _saveShop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data saved!!!"),
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageListScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit"),
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
