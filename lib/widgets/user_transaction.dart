import 'package:expense_calculator/widgets/new_transaction.dart';
import 'package:expense_calculator/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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
  @override
  Widget build(BuildContext context) {
    return Column(children: [
       NewTransaction(addTx: addTransaction,),
        TransactionList(transactions: _userTransaction,)
    ],);
  }
}