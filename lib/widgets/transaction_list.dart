import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
  final  List<Transaction> transactions;
   const TransactionList({Key? key,required this.transactions}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return  Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (context, index) {
        return   Card(
                 child: Row(children: [
                   // ignore: avoid_unnecessary_containers
                   Container(
                     margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                     decoration: BoxDecoration(border: Border.all(color: Colors.purple,width: 2)),
                     padding: const EdgeInsets.all(10),
                     child: 
                     Text(
                       '\$${transactions[index].amount.toStringAsFixed(2)}',                   
                       style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),),
                     ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [                
                     Text(transactions[index].title, 
                     style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)),
                     Text(DateFormat().add_yMMMd().format(transactions[index].date),
                     style: const TextStyle(color: Colors.grey),)
                   ],)
                 ],),);
        },
        itemCount: transactions.length  ,
        
      ),
    );
  }
}