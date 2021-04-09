import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ListItems extends StatelessWidget {
  final List<Transaction> items;
  final Function removeItem;

  ListItems(this.items, this.removeItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: items.isEmpty ? Center(
        child: Column(
          children: <Widget>[
            Text(
              'No items added yet!',
              style: Theme.of(context).textTheme.title,
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover
              )
            )
          ]
        )
      ) : ListView.builder(
        itemBuilder: (ctx, index) => (
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\u{20B9} ${items[index].amount.toStringAsFixed(2)}',)
                  )
                )
              ),
              title: Text(
                items[index].title,
                style: Theme.of(context).textTheme.title
              ),
              subtitle: Text(
                DateFormat('MMM d, y').format(items[index].date),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => removeItem(items[index].id)
              )
            )
          )
        ),
        itemCount: items.length,
      )
    );
  }
}