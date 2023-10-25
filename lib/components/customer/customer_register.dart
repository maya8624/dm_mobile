import 'package:dm_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'customer_modal.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({
    super.key,
  });

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  @override
  Widget build(BuildContext context) {
    final CustomerModal modal = CustomerModal();

    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        onPressed: () => modal.showRegisterForm(context, null),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
