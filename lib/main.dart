import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(const Gastos());
}

class Gastos extends StatelessWidget {
  const Gastos({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(home: const HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.teal,
      fontFamily: 'Quicksand',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontWeight: FontWeight.bold,
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          )
        )
      )
    ),);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final List<Transaction> _transaction = [
    Transaction(
        id: "id1", title: "Conta de agua", value: 154.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
    Transaction(
        id: "id2", title: "Conta de luz", value: 354.2, data: DateTime.now()),
  ];


  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        data: date);
    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionForm(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return TransactionForm(_addTransaction);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despezas pessoais", style: TextStyle(
          fontFamily: 'OpenSans'
        ),),
        actions: [
          IconButton(onPressed: () => _openTransactionForm(context)
              , icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   child: const Card(
            //     color: Colors.blue,
            //     child: Text("Grafico"),
            //     elevation: 5,
            //   ),
            // ),
            Column(
              children: [
                TransactionList(transactions: _transaction, onRemove: _removeTransaction),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionForm(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
