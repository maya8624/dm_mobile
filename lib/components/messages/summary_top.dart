import 'package:dm_mobile/models/message/message.dart';
import 'package:dm_mobile/utils/message_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/message_provider.dart';
import '../../utils/dimensions.dart';

class SummaryTop extends StatelessWidget {
  final Color containerColor;
  final IconData icon;
  final int total;
  final String wording;
  final int? messageType;

  const SummaryTop({
    super.key,
    required this.containerColor,
    required this.icon,
    required this.total,
    required this.wording,
    this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          padding: EdgeInsets.all(Dimensions.height20),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: Dimensions.height10),
        Text(
          wording,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          total.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
