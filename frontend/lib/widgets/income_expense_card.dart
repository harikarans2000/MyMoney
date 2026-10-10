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
        color: data.label == "Income" ? Colors.green.withValues(alpha: 0.6):Colors.red.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      //     alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          
              children: [Text(data.label,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("\u20B9 ${data.amount}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24)))],
            ),
          ),
          Icon(data.icon, color: Colors.white,),
      ],
      ),
    );
  }
}
