import './transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTX;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTX})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  FittedBox(
                    child: Text(
                      "No transaction added yet!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // ignore: sized_box_for_whitespace
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: transactions[index], deleteTX: deleteTX);
              },
              itemCount: transactions.length,
            ),
    );
  }
}
