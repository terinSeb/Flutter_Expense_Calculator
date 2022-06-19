import 'package:expense_calculator/widgets/adaptive_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final txTitle = _titleController.text;
    final txAmount = double.parse(_amountController.text);
    if (txTitle.isEmpty || txAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(txTitle, txAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 70,
                child: Row(
                  children: [
                    // ignore: unnecessary_null_comparison
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Choosen'
                            : 'Selected Date: ${DateFormat.yMEd().format(_selectedDate!)}')),
                    AdaptiveButton(
                        handler: _presentDatePicker, btnText: 'Choose Date')
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).textTheme.headline6?.color,
                    onPrimary: Theme.of(context).textTheme.button?.color),
                child: const Text('Add Transactions'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
