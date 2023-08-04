import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/shop/shop.dart';
import '../providers/message_notifier.dart';
import '../providers/shop_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// final _shopBox = Hive.box<Shop>('shopBox');
_checkPassword() {
  final provider = ShopProvider();
  final shop = provider.getShop();
  if (shop == null) return false;

  final bool isPinCorrect = BCrypt.checkpw("pin", shop.pin);
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
