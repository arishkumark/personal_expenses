import 'package:flutter/material.dart';
import './widgets/listItems.dart';
import './widgets/newItem.dart';
import './widgets/chart.dart';
import './models/transaction.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 20
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transaction> _items = [
    // Transaction(id: 't1', title: 'New shirt', amount: 799.99, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Car wash', amount: 350, date: DateTime.now())
  ];

  List<Transaction> get _recentTrans {
    return _items.where((item) {
      return item.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  void _addNew(String title, double amount, DateTime chosenDate) {
    final newItem = Transaction(title: title, amount: amount, date: chosenDate, id: DateTime.now().toString());
    setState(() {
      _items.add(newItem);
    });
  }

  void _handleAddNew(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder:(_) {
        return NewItem(_addNew);
      },
    );
  }

  void removeItem(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _handleAddNew(context)
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start
          children: <Widget>[
            Chart(_recentTrans),
            ListItems(_items, removeItem)
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _handleAddNew(context)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
