import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/message_provider.dart';
import '../models/message/message.dart';
import '../components/customer_modal.dart';

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({
    super.key,
  });

  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomerModal modal = CustomerModal();
    return FloatingActionButton(
      onPressed: () => modal.showRegisterForm(context, null),
      backgroundColor: Colors.green,
      child: const Icon(
        Icons.add,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
