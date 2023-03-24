import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;

  // I need <spendingPctOfTotal> so that I know inside of that bar
  // how I should color the background because only a percentage of
  // the bar should have the background color,
  final double spendingPctOfTotal;
  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          // FittedBox widget forces its child into to fit into the
          //available space
          // if the child is a text, it even shriks the text
          // So fittedBox() is a widget that scales and position its child
          // within itself
          Container(
            // height: 20,
            height: constraints.maxHeight * 0.15, // 15%
            child: FittedBox(
              // FittedBox prevent Text() widget to keep its original size
              //line wrap
              // ands a forcces  to shrink Text() so that it fit into the box.
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),

          // SizedBox add some spacing
          SizedBox(
            // height: 4,
            height: constraints.maxHeight * 0.05, // 5% of the avl height
          ),
          // our main bar
          Container(
            //  height: 60,
            // constraints.maxHeight is the height our entire chart bar
            // may take
            height: constraints.maxHeight * 0.6, // 60% of the available height
            width: 10,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  //  color: Colors.green,
                  borderRadius: BorderRadius.circular(20), // light grey,
                )),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBoxed() add some spacing
          SizedBox(
            // height: 4,
            height: constraints.maxHeight * 0.05, // 5% of  available height
          ),
          Container(
              height:
                  constraints.maxHeight * 0.15, // 15% of the available height
              // wrap the Text(label) in a FittedBox to ensure, if for 
              // some reason, we should be on a very small device or we 
              // should have only very little height availabe, 
              // the Text() is automatically resized to still fit into
              // the box
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
