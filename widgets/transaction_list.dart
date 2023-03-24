import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxHandler;
  const TransactionList(this.transactions, this.deleteTxHandler);

  @override
  Widget build(BuildContext context) {
    // return Container(
    // find out which tool Flutter gives us to calculate the height
    // dynamically.
    // How can we find out how much height we have available,
    // what the general device height is?
    // If you have a web development background and specifically you
    // know some CSS, which is the styling language in web development
    // then you know that there you also have a feature called media query
    // which also allows you to write styles that behave differently on
    // different device sizes or on different screen sizes.
    //**** The MediaQuery() class here is exposed by the Flutter material
    //**** package,
    // */ */ the <context> is the metadata object with some information
    // about our widget and its position in the tree and as it turns out,
    // this connection also all allows us to find out which general device
    // size we have available because that's something which Flutter manages
    // behind the scenes for us

    // <size> property gives you access to an object where you have a
    // height and width.
    // 1 =  take full height
    // 0 = take 0 height
    // In this case here, our container with the transactions should only
    // take a fraction of that height. (height * 0.6) == fixed height of
    // only 60%

    //  height: MediaQuery.of(context).size.height * 0.6 ,
    // child: transactions.isEmpty
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            print("height for No transaction yet!");
            print(constraints.maxHeight);
            return Column(
              children: <Widget>[
                Text(
                  'No transaction yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                //SizedBox() is a Widget that allows us to add a box with
                // specific size.
                // its is like Container but you can also not define
                // a child and therfore SizedBox() are common way of
                // using seperator, as to provide some space between
                // elements like emty box which we don't see on the screen
                // but which occupies its space,
                SizedBox(
                  height: 20,
                ),

                // We have no bounderies for the image
                // we have the container but the direct parent of the image
                // is not the container but the Column and Columns takes
                // as much height as they get. So the image is not able
                // to infer the size of its parent,
                /*
                  The solution is to wrap our image into a container
                */
                Container(
                    // height: 200,
                    height: constraints.maxHeight * 0.6,
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      // BoxFit.cover take the height of its direct parent
                      // and squeeze the image in there.
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView(
            children: transactions.map((tx) => TransactionItem(
                // The unique key class is build into Flutter 
                // and it automatically creates a unique key for 
                // every item, so every new item gets its own unique key 
                // attached.
                  // key: UniqueKey(),
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteTxHandler: deleteTxHandler,
                )).toList(),
          );
    // );
  }
}
