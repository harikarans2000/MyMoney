import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionService transactionService;
  final String type;

  const AddTransactionScreen({
    super.key,
    required this.transactionService,
    required this.type,
  });

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {

  final TextEditingController amountController =
      TextEditingController();

  final TextEditingController noteController =
      TextEditingController();

  String category = "Salary";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ${widget.type}"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

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
              value: category,

              items: const [

                DropdownMenuItem(
                  value: "Salary",
                  child: Text("Salary"),
                ),

                DropdownMenuItem(
                  value: "Food",
                  child: Text("Food"),
                ),

                DropdownMenuItem(
                  value: "Shopping",
                  child: Text("Shopping"),
                ),

                DropdownMenuItem(
                  value: "Travel",
                  child: Text("Travel"),
                ),

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

                  widget.transactionService.addTransaction(

                    TransactionModel(

                      type: widget.type,

                      category: category,

                      amount: double.parse(
                        amountController.text,
                      ),

                      date: DateTime.now(),

                      note: noteController.text,
                    ),

                  );

                  Navigator.pop(context);

                },

                child: const Text("Save"),
              ),
            )

          ],
        ),
      ),
    );
  }
}