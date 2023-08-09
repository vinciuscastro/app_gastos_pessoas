import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'models/db.dart';

void main() => runApp(const Gastos());


class Gastos extends StatelessWidget {
  const Gastos({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Quicksand',
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
          )),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),),),),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _transaction = [];

  @override
  void initState(){
    super.initState();
    _refresh();
  }

  _refresh() async{
    List<Transaction> x = await DatabaseHelper.instance.selectRecords();
    setState(() {
      _transaction = x;
    });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: null,
        title: title,
        value: value,
        data: date);
    setState(() {
      DatabaseHelper.instance.insertRecord(newTransaction);
      _refresh();
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(int id) {
    setState(() {
      DatabaseHelper.instance.deleteRecord(id);
      _refresh();
    });
  }

  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despezas pessoais",
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
              onPressed: () => _openTransactionForm(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                TransactionList(
                    transactions: _transaction, onRemove: _removeTransaction),
              ],
            ),
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
