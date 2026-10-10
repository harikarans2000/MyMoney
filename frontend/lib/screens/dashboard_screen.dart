import 'package:flutter/material.dart';
import 'package:frontend/services/transaction_service.dart';

//import '../services/transaction_service.dart';
import 'add_transaction_screen.dart';
import '../widgets/income_expense_card.dart';
import '../widgets/recent_transaction.dart';
import 'transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.transactionService});
  final TransactionService transactionService;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = "Harikaran"; // Replace with the actual user's name

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16 * 4),
            ListTile(
              title: Text("Hey Hari !", style: TextStyle(fontSize: 30)),
              leading: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              trailing: Icon(Icons.notifications),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    "\u20B9 ${widget.transactionService.balance.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text("Total Balance", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 16 * 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IncomeExpenseCard(
                    data: Data(
                      "Income",
                      widget.transactionService.totalIncome.toStringAsFixed(2),
                      Icons.arrow_upward,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: IncomeExpenseCard(
                    data: Data(
                      "Expense",
                      widget.transactionService.totalExpense.toStringAsFixed(2),
                      Icons.arrow_downward,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text("Recent Transactions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TransactionScreen(transactionService: widget.transactionService),
                  ),
                  );
              }, 
              child: 
              const Row(
                children: [
                  Text("See All"),Icon(Icons.arrow_forward, size: 18)
                ],))
              ],),
            
            SizedBox(height: 16),
            Trans(transaction: widget.transactionService.recentTransactions),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => AddTransactionScreen(
                          transactionService: widget.transactionService
                        ),
                      ),
                    ).then((_) {setState(() {});
                     });
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  
                  child: Icon(Icons.add,size: 30,),
                  
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                
          
    );
  }
}
