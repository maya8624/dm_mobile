import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';

import '../controllers/business_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// final _shopBox = Hive.box<Shop>('shopBox');
_checkPassword() {
  final controller = BusinessController();
  final business = controller.getBusiness();
  if (business == null) return false;

  final bool isPinCorrect = BCrypt.checkpw("pin", business.passcode);
  if (!isPinCorrect) return false;
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    _checkPassword();
                  },
                  child: const Text('Validate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
