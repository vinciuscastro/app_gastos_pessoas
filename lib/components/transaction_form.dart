import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueC = TextEditingController();
  final titleC = TextEditingController();
  DateTime? _selectedData;

  _submitForm() {
    final title = titleC.text;
    final value = double.tryParse(valueC.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedData == null) return;
    widget.onSubmit(title, value, _selectedData!);
  }

  _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((value) {
          if (value==null) return;
          setState(() {
            _selectedData = value;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: "Titulo"),
            ),
            TextField(
              controller: valueC,
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Valor"),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    _selectedData == null ? "Nenhuma data selecionada"
                        : 'Data selecionada: ${DateFormat("dd/MM/yy").format(_selectedData!)}'
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text("Selecionar data"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  style: TextButton.styleFrom(
                      // foregroundColor: Theme.of(context).primaryColor,
                      // backgroundColor: Theme.of(context).textTheme.labelLarge.color,
                      ),
                  child: const Text(
                    "Nova transação",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
