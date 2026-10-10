import 'package:flutter/material.dart';

import '../services/transaction_service.dart';
import '../widgets/recent_transaction.dart';
import '../models/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  final TransactionService transactionService;

  const TransactionScreen({super.key, required this.transactionService});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String selectedType = 'All';
  String selectedCategory = 'All';
  DateTimeRange? selectedDateRange;

  final List<String> types = ['All', 'Income', 'Expense'];

  final List<String> categories = [
    'All',
    'Salary',
    'Food',
    'Shopping',
    'Travel',
  ];

  List<TransactionModel> getFilteredTransactions() {
    final transactions = widget.transactionService.allTransactions;

    return transactions.where((transaction) {
      // Filter by type
      final matchesType = selectedType == 'All' || transaction.type == selectedType;

      // Filter by category
      final matchesCategory =
          selectedCategory == 'All' || transaction.category == selectedCategory;

      // Filter by date range
      bool matchesDate = true;

      if (selectedDateRange != null) {
        final date = transaction.date;
        final start = selectedDateRange!.start;
        final end = selectedDateRange!.end;

        final transactionDate = DateTime(date.year, date.month, date.day);
        final startDate = DateTime(start.year, start.month, start.day);
        final endDate = DateTime(end.year, end.month, end.day);

        matchesDate =
            !transactionDate.isBefore(startDate) &&
            !transactionDate.isAfter(endDate);
      }

      return matchesType && matchesCategory && matchesDate;
    }).toList();
  }

  Future<void> selectDateRange() async {
    final now = DateTime.now();

    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 10),
      initialDateRange: selectedDateRange,
      helpText: 'Select transaction date range',
    );

    if (result != null) {
      setState(() {
        selectedDateRange = result;
      });
    }
  }

  void resetFilters() {
    setState(() {
      selectedType = 'All';
      selectedCategory = 'All';
      selectedDateRange = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactions = getFilteredTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
        actions: [
          TextButton.icon(
            onPressed: resetFilters,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
          ),
        ],
      ),

      body: Column(
        children: [
          // Filter controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        items: types.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedType = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Date range filter
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: selectDateRange,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      selectedDateRange == null
                          ? 'Filter by date'
                          : '${MaterialLocalizations.of(context).formatMediumDate(selectedDateRange!.start)} - '
                                '${MaterialLocalizations.of(context).formatMediumDate(selectedDateRange!.end)}',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Result count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${transactions.length} transaction(s) found',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Filtered results
          Expanded(
            child: transactions.isEmpty
                ? const Center(child: Text('No matching transactions found'))
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [Trans(transaction: transactions)],
                  ),
          ),
        ],
      ),
    );
  }
}
