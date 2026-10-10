import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'analytics_screen.dart';

import 'profile_screen.dart';
import '../services/transaction_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final TransactionService transactionService = TransactionService();
  

  

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
    DashboardScreen(transactionService: transactionService),
    //TransactionScreen(transactionService: transactionService),
    AnalyticsScreen(),
    ProfileScreen(),
  ];
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        // type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Analytics",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
