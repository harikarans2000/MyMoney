import 'package:flutter/material.dart';

import '../services/transaction_service.dart';
import 'add_transaction_screen.dart';
import '../widgets/income_expense_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = "Harikaran"; // Replace with the actual user's name

  final TransactionService transactionService = TransactionService();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 16*4,),
            ListTile(
              
              title: Text("Hey Hari !",style: TextStyle(fontSize: 30),),
              leading: CircleAvatar(radius: 50, child: Icon(Icons.person,size: 50,)),
              trailing: Icon(Icons.notifications),
            ),
            SizedBox(height: 16,),
            Center(child: Column(children: [
              Text("\u20B9 ${transactionService.balance.toStringAsFixed(2)}",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              Text("Total Balance",style: TextStyle(fontSize: 16,))
            ],),),
            SizedBox(height: 16*2,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Expanded(child: IncomeExpenseCard(data: Data("Income",transactionService.totalIncome.toStringAsFixed(2),Icons.arrow_upward))),
              SizedBox(width: 16),
              Expanded(child:IncomeExpenseCard(data: Data("Expense",transactionService.totalExpense.toStringAsFixed(2),Icons.arrow_downward))),
            ]),
            
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => AddTransactionScreen(
                          transactionService: transactionService,

                          type: "Income",
                        ),
                      ),
                    );

                    setState(() {});
                  },
                  child: Text("Add Income", style: TextStyle(fontSize: 20)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => AddTransactionScreen(
                          transactionService: transactionService,

                          type: "Expense",
                        ),
                      ),
                    );

                    setState(() {});
                  },
                  child: Text("Add Expense", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
