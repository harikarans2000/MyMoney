import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class Trans extends StatelessWidget {
  final List<TransactionModel> transaction;

  const Trans({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    if (transaction.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "No transactions yet",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: transaction.map((trans) {
        final isIncome = trans.type == "Income";

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: isIncome
                  ? Colors.green.withValues(alpha: 0.12)
                  : Colors.red.withValues(alpha: 0.12),
              child: Icon(
                isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                color: isIncome ? Colors.green : Colors.red,
              ),
            ),
            title: Text(trans.category, style: const TextStyle(fontSize: 20)),
            subtitle: Text(
              DateFormat('dd MMM yyyy').format(trans.date),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            trailing:Text(
                  "${isIncome ? '+' : '-'} \u20B9${trans.amount}",
                  style: TextStyle(
                    color: isIncome ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
          ),
        );
      }).toList(),
    );
  }
}
