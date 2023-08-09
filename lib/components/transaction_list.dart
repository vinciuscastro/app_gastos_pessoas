import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function (int) onRemove;
  const TransactionList({super.key, required this.transactions, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Nenhum cadastro",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/images/waiting.png",
                  fit: BoxFit.cover,),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final e = transactions[index];
                int? id = e.id;
                return Card(
                  elevation: 5, 
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text("R\$ ${e.value.toStringAsFixed(2)}"),
                        ),
                      ),
                    ),
                    title: Text(
                      e.title,
                      style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    subtitle: Text(
                      DateFormat("dd MMM y").format(e.data),
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => onRemove(id!),
                    ),
                    ),
                );
              }),
    );
  }
}