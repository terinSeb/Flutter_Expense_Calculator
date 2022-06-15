
import 'package:expense_calculator/widgets/chart.dart';

import './widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    
    // ignore: prefer_const_constructors
    return  MaterialApp(
      title: 'Flutter App',
      home:  MyHomePage(),
      theme: 
      ThemeData(
        primarySwatch: Colors.red,       
        // accentColor: Colors.amber,    
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6:const TextStyle(fontFamily: 'Opensans',fontSize: 20,fontWeight: FontWeight.bold)
          ),
          appBarTheme: const AppBarTheme(
                      titleTextStyle: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 31,
                      fontWeight: FontWeight.bold
                      )
)
        // appBarTheme: AppBarTheme(
        //   // ignore: deprecated_member_use
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     headline6:const TextStyle(fontFamily: 'Opensans',fontSize: 50,fontWeight: FontWeight.bold)
        //   )
        )
    ,
      
    //    theme.copyWith(
    // colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
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
    //  Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    //   Transaction(id: 't2', title: 'Weekly groceries', amount: 16.53, date: DateTime.now())
   ];
   List<Transaction> get _recentTransaction{
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
   }
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
          // Container(
          //   width: double.infinity,
          //   child: const Card(
          //     color: Colors.blue,
          //     child: Text('chart'),)
          //   ),
             Chart(transactions: _recentTransaction) ,
        TransactionList(transactions: _userTransaction,)
  
          ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: () => _shoAddNewTransaction(context), child: const Icon(Icons.add)),
      );
  }
}
