import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    // So you really need to accept key when you own widget needs to have
    // a key and you only need to have a key on your widget if it's the 
    // topmost item(a stateful widget) in a List or in situations where
    // you have this strange behaviour that you get wrong state attached
    // to your element.
    Key key,// key simply make it easier for Flutter to identify the 
    // connected widget.
    @required this.transaction,
    @required this.deleteTxHandler,
  }) : super(key: key);//
  // super refers to the parent class, by calling super like a function
  // you're instantiating the parent class. Normally you don't need to 
  // do that because Flutter does if for you automatically.
  // You only need to do it your own if you want to pass some extra data
  // to the parent class and typically that one piece of data you might
  // want ot pass to your parent class which always is a statefull
  // or stateless widget for you own widget classes is a possible <key>
  // you're accepting because that <keying> functionality is managed by 
  // Flutter behind the scenes. 
  // So if you get a key on your widget, you need to forward it to the
  // Flutter base widget so that Flutter knows what to do with that key
  // , your widget alone doesn't do anything with that argument, 
  // We're are not using that argument anywhere in our class here,
  // So we need to forward this to the parent widget.

  final Transaction transaction;
  final Function deleteTxHandler;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    // these are the colors to use as background for the CircleAvatar
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.green,
    ];
    //
    // Note we don't wrap _bgColor here in setState() inside initState()
    // because initState is called before build() is executed. 
    // so build will take in account any changes made inside initState() 
    // and therefore you shouldn't call setState() inside here 
    // just update any properties just like this
    // set the background color
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          // this will use randomly generated background color
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? ElevatedButton.icon(
                label: Text('Delete'),
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTxHandler(widget.transaction.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                // color:Theme.of(context).errorColor
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  widget.deleteTxHandler(widget.transaction.id);
                },
              ),
      ),
    );
  }
}
