import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './listItems.dart';
import './newItem.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  final List<Transaction> _items = [
    Transaction(id: 't1', title: 'New shirt', amount: 799.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Car wash', amount: 350, date: DateTime.now())
  ];

  void _addNew(String title, double amount) {
    final newItem = Transaction(title: title, amount: amount, date: DateTime.now(), id: DateTime.now().toString());
    setState(() {
      _items.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewItem(_addNew),
      ]
    );
  }
}