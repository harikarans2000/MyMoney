class TransactionModel {
  final String type;
  final String category;
  final double amount;
  final DateTime date;
  final String note;

  TransactionModel({
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });
}