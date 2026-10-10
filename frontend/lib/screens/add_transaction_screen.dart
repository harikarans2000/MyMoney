import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionService transactionService;

  const AddTransactionScreen({super.key, required this.transactionService});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  String category = "Salary";
  String type = "Income";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add $type")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: type,
              items: const [
                DropdownMenuItem(value: "Income", child: Text("Income")),
                DropdownMenuItem(value: "Expense", child: Text("Expense")),
              ],
              onChanged: (value) {
                setState(() {
                  type = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: category,

              items: const [
                DropdownMenuItem(value: "Salary", child: Text("Salary")),

                DropdownMenuItem(value: "Food", child: Text("Food")),

                DropdownMenuItem(value: "Shopping", child: Text("Shopping")),

                DropdownMenuItem(value: "Travel", child: Text("Travel")),
              ],

              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: noteController,

              decoration: const InputDecoration(
                labelText: "Note",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountController.text);
                  if (amount == null || amount <=0 ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid amount"),
                      ),
                    );
                    return;
                  }
                  widget.transactionService.addTransaction(
                    TransactionModel(
                      type: type,

                      category: category,

                      amount: amount,

                      date: DateTime.now(),

                      note: noteController.text,
                    ),
                  );

                  Navigator.pop(context);
                },

                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
