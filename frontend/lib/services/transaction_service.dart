import '../models/transaction_model.dart';

class TransactionService {
  final List<TransactionModel> transactions = [];

  void addTransaction(TransactionModel transaction) {
    transactions.add(transaction);
  }

  double get totalIncome {
    return transactions
        .where((t) => t.type == "Income")
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return transactions
        .where((t) => t.type == "Expense")
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance {
    return totalIncome - totalExpense;
  }
}