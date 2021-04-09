import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupedItem {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum = 0.0;

      for( var i = 0; i < recentTrans.length; i++) {
        if(recentTrans[i].date.day == weekDay.day &&
        recentTrans[i].date.month == weekDay.month &&
        recentTrans[i].date.year == weekDay.year) {
          totalSum += recentTrans[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedItem.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedItem);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedItem.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                item['day'],
                item['amount'],
                totalSpending == 0.0 ? 0.0 : (item['amount'] as double) / totalSpending
              ),
            );
          }).toList()
        )
      )
    );
  }
}