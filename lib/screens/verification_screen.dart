import 'package:bcrypt/bcrypt.dart';
import 'package:dm_mobile/providers/shop_provider.dart';
import 'package:dm_mobile/screens/message_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool _verifyPin(String? pinEntered) {
    if (pinEntered == null || pinEntered.length < 4) return false;

    final provider = ShopProvider();
    final shop = provider.getShop();
    if (shop == null) return false;

    final bool isPinCorrect = BCrypt.checkpw(pinEntered, shop.pin);
    if (!isPinCorrect) return false;

    return true;
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Color.fromRGBO(114, 178, 238, 1),
      ),
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(243, 246, 249, 1),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(199, 201, 202, 1),
      ),
    );

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Verification Code',
                style: GoogleFonts.urbanist(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                width: width,
                child: Pinput(
                  controller: pinController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  length: 4,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  focusNode: focusNode,
                  validator: (value) {
                    final isVerified = _verifyPin(value);
                    if (isVerified == false) {
                      pinController.clear();
                      return 'pin is incorrect or not registered yet';
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageListScreen(),
                      ),
                    );
                    return null;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     verifyPin("123");
              //     focusNode.unfocus();
              //     formKey.currentState!.validate();
              //   },
              //   child: const Text('Validate'),
              // ),
            ],
          ),
        ));
  }
}