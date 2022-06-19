import 'dart:io';
import 'package:expense_calculator/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          // accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
              button: const TextStyle(color: Colors.white)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 31,
                fontWeight: FontWeight.bold),
          )
          // appBarTheme: AppBarTheme(
          //   // ignore: deprecated_member_use
          //   textTheme: ThemeData.light().textTheme.copyWith(
          //     headline6:const TextStyle(fontFamily: 'Opensans',fontSize: 50,fontWeight: FontWeight.bold)
          //   )
          ),

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
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String txTitle, double txAmount, DateTime chooseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chooseDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _shoAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addTx: addTransaction),
        );
      },
    );
  }

  bool _changedValue = false;

  @override
  Widget build(BuildContext context) {
    final mediaQry = MediaQuery.of(context);
    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
          middle: const Text('Flutter App'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: const Icon(CupertinoIcons.add),
                onTap: () => _shoAddNewTransaction(context),
              )
            ],
          ));
    } else {
      appBar = AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
              onPressed: () => _shoAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      );
    }

    final isLandScaprMode = mediaQry.orientation == Orientation.landscape;
    // ignore: sized_box_for_whitespace
    var trxList = Container(
        height: (mediaQry.size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            .7,
        width: mediaQry.size.width,
        child: TransactionList(
          transactions: _userTransaction,
          deleteTX: _deleteTransaction,
        ));
    var scfBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ignore: sized_box_for_whitespace
          // Container(
          //   width: double.infinity,
          //   child: const Card(
          //     color: Colors.blue,
          //     child: Text('chart'),)
          //   ),
          // ignore: sized_box_for_whitespace
          if (isLandScaprMode)
            Text(
              'Show Chart',
              style: Theme.of(context).textTheme.headline6,
            ),
          if (isLandScaprMode)
            Switch(
                value: _changedValue,
                onChanged: (val) {
                  setState(() {
                    _changedValue = val;
                  });
                }),
          if (!isLandScaprMode)
            // ignore: sized_box_for_whitespace
            Container(
                height: (mediaQry.size.height -
                        appBar.preferredSize.height -
                        mediaQry.padding.top) *
                    .3,
                width: mediaQry.size.width,
                child: Chart(transactions: _recentTransaction)),
          if (!isLandScaprMode) trxList,
          if (isLandScaprMode)
            _changedValue
                // ignore: sized_box_for_whitespace
                ? Container(
                    height: (mediaQry.size.height -
                            appBar.preferredSize.height -
                            mediaQry.padding.top) *
                        .7,
                    width: mediaQry.size.width,
                    child: Chart(transactions: _recentTransaction))
                // ignore: sized_box_for_whitespace
                : trxList
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
            child: scfBody,
          )
        : Scaffold(
            appBar: appBar,
            body: scfBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _shoAddNewTransaction(context),
                    child: const Icon(Icons.add)),
          );
  }
}
