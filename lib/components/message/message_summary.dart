import 'package:dm_mobile/components/message/summary_top.dart';
import 'package:flutter/material.dart';

import '../../utils/wordings.dart';
import '../../view_models/summary_view.dart';

class MessageSummary extends StatelessWidget {
  final SummaryView summary;

  const MessageSummary({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SummaryTop(
          containerColor: Colors.green,
          icon: Icons.restart_alt_outlined,
          total: summary.prepTotal,
          wording: Wordings.prep,
        ),
        SummaryTop(
          containerColor: Colors.orange.shade600,
          icon: Icons.mark_chat_read_outlined,
          total: summary.sentTotal,
          wording: Wordings.sent,
        ),
        SummaryTop(
          containerColor: Colors.redAccent,
          icon: Icons.task_alt_outlined,
          total: summary.completedTotal,
          wording: Wordings.completed,
        ),
        SummaryTop(
          containerColor: const Color.fromARGB(255, 7, 161, 167),
          icon: Icons.add_circle_outline,
          total: summary.grandTotal,
          wording: Wordings.total,
        ),
      ],
    );
  }
}
