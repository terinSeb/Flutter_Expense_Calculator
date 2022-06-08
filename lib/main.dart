

import 'package:intl/intl.dart';

import './transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
   final List<Transaction> transaction = [
     Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
      Transaction(id: 't2', title: 'Weekly groceries', amount: 16.53, date: DateTime.now())
   ];

   MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        // ignore: sized_box_for_whitespace
        Container(
          width: double.infinity,
          child: const Card(
            color: Colors.blue,
            child: Text('chart'),)
          ),
          // ignore: prefer_const_literals_to_create_immutables
          Card(child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [                      
              const TextField(decoration: InputDecoration(labelText: 'Title'),),
              const TextField(decoration: InputDecoration(labelText: 'Amount'),),
              TextButton(
                onPressed: () {}, 
                child:  const Text('Add Transactions',style: TextStyle(color: Colors.purple)),
                )
            ],),
          ),),
        Column(
          children:  transaction.map((tx) => 
           Card(
             child: Row(children: [
               // ignore: avoid_unnecessary_containers
               Container(
                 margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                 decoration: BoxDecoration(border: Border.all(color: Colors.purple,width: 2)),
                 padding: const EdgeInsets.all(10),
                 child: 
                 Text(
                   '\$${tx.amount}',                   
                   style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),),
                 ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [                
                 Text(tx.title, 
                 style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)),
                 Text(DateFormat().add_yMMMd().format(tx.date),
                 style: const TextStyle(color: Colors.grey),)
               ],)
             ],),)
           
           ).toList(),
           )
        ],),
      );
  }
}
