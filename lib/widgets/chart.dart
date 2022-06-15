import 'package:expense_calculator/models/transaction.dart';
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
        return {'day': DateFormat.E(week), 'amount':totalSum}; });
    }
  @override
  Widget build(BuildContext context) {


   
    return const Card(elevation: 6, margin: EdgeInsets.all(20),
    // child: ,
    );
  }
}