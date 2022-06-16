

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  const Chart({Key? key, required this.transactions}) : super(key: key);

     List<Map<String,Object>> get groupTransactionValue{
      return List.generate(7, (index) { 
        final week = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0;
        for (var i = 0; i < transactions.length; i++)
        {
if(transactions[i].date.day == week.day &&
transactions[i].date.month == week.month &&
transactions[i].date.year == week.year)
{
  totalSum  +=  transactions[i].amount;
}
        }
        return {'day': DateFormat.E().format(week).substring(0,1), 'amount':totalSum}; }).reversed.toList();
    }
    double get totalSpending{
      return groupTransactionValue.fold(0.0, (previousValue, element) => previousValue + (element['amount'] as double));
    }
  @override
  Widget build(BuildContext context) {   
    return  Card(elevation: 6, margin: const EdgeInsets.all(20),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
      groupTransactionValue.map((elm) {
   return 
   Flexible(
      fit: FlexFit.tight,
       child:
        ChartBar(label: (elm['day'] as String), 
        spendingAmount: (elm['amount'] as double),
         spendingPctOfTotal: totalSpending == 0.0 ? 0.0 : (elm['amount'] as double)/ totalSpending),
   );
      }
       ).toList(),  ),
    ) ,
    );
  }
}