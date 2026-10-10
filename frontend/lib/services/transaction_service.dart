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

  List<TransactionModel> get allTransactions {
    List<TransactionModel> recent = List.from(transactions);

    //recent.sort((a, b) => b.date.compareTo(a.date));

    return recent;
  }
  
  List<TransactionModel> get recentTransactions {
    List<TransactionModel> recent = List.from(transactions);

    recent.sort((a, b) => b.date.compareTo(a.date));

    return recent.take(3).toList();
  }

  List<TransactionModel> get incomeTransactions {
    return transactions.where((t) => t.type == "Income").toList();
  }

  List<TransactionModel> get expenseTransactions {
    return transactions.where((t) => t.type == "Expense").toList();
  }

}
