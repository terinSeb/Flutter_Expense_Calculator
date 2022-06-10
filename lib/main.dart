
import './widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return  MaterialApp(
      title: 'Flutter App',
      home:  MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final List<Transaction> _userTransaction = [
     Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
      Transaction(id: 't2', title: 'Weekly groceries', amount: 16.53, date: DateTime.now())
   ];
   void addTransaction(String txTitle, double txAmount){
 final newTx = Transaction(id:  DateTime.now().toString(), title: txTitle, amount: txAmount, date:  DateTime.now());
 setState(() {
   _userTransaction.add(newTx);
 });
}


 void _shoAddNewTransaction(BuildContext ctx){
   showModalBottomSheet(context: ctx, builder: (_) {
return GestureDetector(onTap: () {},
behavior: HitTestBehavior.opaque,
child: NewTransaction(addTx: addTransaction) ,
);
 
   },);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(onPressed:  () => _shoAddNewTransaction(context), icon: const Icon(Icons.add))
        ],
      ),      
      body: SingleChildScrollView(        
        child: Column(
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
              
        TransactionList(transactions: _userTransaction,)
  
          ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: () => _shoAddNewTransaction(context), child: const Icon(Icons.add)),
      );
  }
}
