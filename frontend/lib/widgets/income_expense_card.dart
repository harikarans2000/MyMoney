import 'package:flutter/material.dart';

class Data {
  final String label;
  final String amount;
  final IconData icon;
  const Data(this.label, this.amount, this.icon);
}

class IncomeExpenseCard extends StatelessWidget {
  final Data data;
  const IncomeExpenseCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: data.label == "Income" ? Color(0xFF65d5ca):Color(0xFFf28080),
        borderRadius: BorderRadius.circular(10),
      ),
      //     alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                Text("\u20B9 ${data.amount}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24))],
            ),
          ),
          Icon(data.icon, color: Colors.white,),
        ],
      ),
    );
  }
}
