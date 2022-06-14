

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
   const NewTransaction({Key? key,required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
final _titleController = TextEditingController();

final _amountController = TextEditingController();

void submitData(){
  final txTitle = _titleController.text;
  final txAmount = double.parse(_amountController.text);
  if(txTitle.isEmpty || txAmount <= 0  ){
    return;
  }
 widget.addTx(txTitle,txAmount);
 Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return    Card(child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [                      
               TextField(
                 decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                 onSubmitted: (_) => submitData()
                 ,),
               TextField(
                 decoration: const InputDecoration(labelText: 'Amount'),
                 controller: _amountController,
                 keyboardType: TextInputType.number,
                 onSubmitted: (_) => submitData(),
                 ),
              TextButton(
                onPressed: submitData, 
                child:  const Text('Add Transactions',style: TextStyle(color: Colors.purple)),
                )
            ],),
          ),);
  }
}