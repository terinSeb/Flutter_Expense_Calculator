

import 'package:flutter/material.dart';
final TextEditingController _titleController = TextEditingController();
final TextEditingController _amountController = TextEditingController();
class NewTransaction extends StatelessWidget {
  final Function addTx;
   const NewTransaction({Key? key,required this.addTx}) : super(key: key);


void submitData(){
  final txTitle = _titleController.text;
  final txAmount = double.parse(_amountController.text);
  if(txTitle.isEmpty || txAmount <= 0  ){
    return;
  }
 addTx(txTitle,txAmount);
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