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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        // ignore: sized_box_for_whitespace
        Container(
          width: double.infinity,
          child: const Card(
            color: Colors.blue,
            child: Text('chart'),)
          ),
        const Card(child: Text('Lis of Rx'),)
        ],),
      );
  }
}
