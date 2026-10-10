import 'package:flutter/material.dart';

import "screens/home_screen.dart";

void main() {
  runApp(const MyMoneyApp());
}

class MyMoneyApp extends StatelessWidget {
  const MyMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMoney',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      
    );
  }
}
