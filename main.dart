import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';

//import './widgets/user_transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  //SystemChrome allows you to set some application wide or system wide
  // settings for your app
  //
  // As for the latest version of Flutter you also need to add
  // WidgetsFlutterBinding.ensureInitialized() before you try to set
  // the SystemChrome.setPreferredOrientations
  // otherwise on some devices it won't work.
  // //********** */
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ********ADD THEME &&&& ADD CUSTOM FONT **********
      // <theme:> argument allows to set up a global appliaction-wide theme
      // and theme basically means a combination of colors, of text-styles,
      // font-sizes that your entire application uses, that many of Flutter's
      // widgets then use as default and that you can tap into when you want
      // to color you own widgets
      // <theme:> takes a <ThemeData> object, it's not a Widget but a normal
      // object based on a class,

      // Note: using themes is a crucial and super important feature in Flutter
      // apps because it makes styling and coloring so much easier.
      theme: ThemeData(
        // Now the <ThemeData> has a lot of argument which you can configure
        // the good thing is you dont have to configure all of them
        // a lot of theme settings are derived from other theme settings so
        // that you only have to define a couple of main settings, unless
        // you really want to control evert nitty-gritty details in you app

        // the differece b/w <primaryColor> is that the primary color is one
        // single color, like blue, red and <primarySwatch is based on one
        // single color but it automatically generates different shades of that
        // color automatically behind the scenes and many of Flutter's default
        // widgets need these different shades and
        // if you only define your <primaryColor> not he <primarySwatch>, then
        // these shades are not available and therefore all the Flutter widgets
        // will fallback to other default or use your <primaryColor> which can
        // in some places, look worse,
        // So you should define a <primarySwatch> there
        primarySwatch: Colors.purple,
        // Colors.() gives you a bunch of material colors and material colors
        // are more complex objects

        //<accentColor> is an alternative color because often you want to mix
        // colors and you look into the official material design documentation
        // if you want to get ideas for how to mix and match colors and which
        // combination work,
        // accentColor: Colors.amber,

        // errorColor: ,

        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.purple,
        //   errorColor: Colors.red,
        // ),
        // useMaterial3: true,

        // Set custom fonts
        fontFamily: 'Quicksand',

// assign a new TextTheme for our appBar , all text element in the appBar
// will receive the theme, based on the default textTheme(so that we don't)
// have to override everythings like font size and so on) but instead
// we use the default textTheme and copy that with some new overwritten
// values
        appBarTheme: AppBarTheme(
          // textTheme: ThemeData.light().textTheme.copyWith(
          //         titleLarge: TextStyle(
          //       fontFamily: 'OpenSans',
          //       fontSize: 40,
          //       //fontWeight: FontWeight.bold,
          //     )),

          // Add font styles for all "title" text in AppBar
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        // styles for other 'title' in the app
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              labelLarge: TextStyle(
                color: Colors.white,
              ),
            ),
      ),

      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// mixin : it's a bit like a class and it's a bit like extending a class.
// but now your class is not based on that class But it adds a certain
// feature from that class mixing into your class, so you're adding
// certain properties, certain methods this other class has without fully
// inheriting this other class.
// It has some technical differences. You also can only inherit from one
// class, So if you want to bring in features from multiple classes, you 
// would use a mixin.
// You use a mixin by adding a <with> keyword after your class and after
// the class you're extending from possibly and then the name of the class
// you want to extend
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // _showChart holds the value of the Switch
  bool _showChart = false;

  @override
  void initState() {
    // add a listner to app lifecycle
    // here we're telling Flutter that whenever my lifecycle state changes
    // I want you to go to a certain observer 
    // and call didChangeAppLifeCycleState()
    // <this> means this class itself, so this class need to have a method
    // didChangeAppLifeCycleState() in it 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.99,
    //   date: DateTime.now(),
    // )
  ];

  @override
  // this method is triggered whenever your lifecycle state changes, 
  // whenever the app reaches a new state in lifecycle
  void didChangeAppLifecycleState(AppLifecycleState state){
    // now here we can react to changes in our app lifecycle
    print(state);

  }
  
  @override
  void dispose(){
    super.dispose();
    // should also clear listener to lifecycle changes when that widget,
    // when that state object is not required anymore.

    // if you have a bigger app and you add your app lifecycle listener
    // in just one child widget somewhere down the widget tree of your
    // app because in the child widget you're intereseted in changes to
    // the lifecycle of the app, well then when that child widget gets
    // removed, you certainly also want to clear your lifecycle listener
    // to avoid memory leaks.
    WidgetsBinding.instance.removeObserver(this);
  }

  // getter
  List<Transaction> get _recentTransaction {
    // filter out transaction that happened in the last week.

    // .where() allow you to run a function on every item in a list
    // if the func() return <true> the included in the
    // newly returned list otherwise
    // it's not included in that newly returned list
    return _userTransactions.where((tx) {
      // Only transactions that are younger than 7 days are included here.
      return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7))); // today - 7 days
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(), // to generate unique id
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (contx) {
          // return the widget we want to show inside of that modal sheet.

          // GestureDetector
          //   return GestureDetector(
          //     // register for ==>  onTap gesture
          //     onTap: () {
          //       //do nothing;
          //     },
          //     behavior: HitTestBehavior.opaque,// this is important
          //     child: NewTransaction(_addNewTransaction));
          // }
          return SingleChildScrollView(
            child: Container(
                // height: MediaQuery.of(context).size.height / 2+
                // MediaQuery.of(context).viewInsets.bottom,
                // width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height * .5 + MediaQuery.of(context).viewInsets.bottom * .7,
                // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20,),
                // padding: EdgeInsets.only(
                //   // top: 10,
                //   // left: 10,
                //   // right: 10,
                //   // MediaQuery.of(context).viewInsets gives information about anything
                //   // that's lapping into our view and TYPICALLY, that's the soft keyboard
                //   // and then <>.viewInsets.bottom property tells us how much space is
                //   // occupied by that softkeyborad and I want to adjust the bottom
                //   // padding of that card + 10(which should always be there to lift
                //   // upwards, to move up entire input area)
                //   bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                // ),
                padding: EdgeInsets.only(
                    top: 20,
                    bottom: MediaQuery.of(contx).viewInsets.bottom + 10),
                child: NewTransaction(_addNewTransaction)),
          );
        });
  }

  @override
  Widget build(BuildContext ctx) {
    // now we don't create the object and tap into a new object all the
    // time which simply costs more performance and can lead to
    // unnecessary re-render cylces instead we set up one connection,
    // get the media query data once and store that in one object and then
    // we reuse that object throughout your widget tree or throughout
    // your build method here which is more effecient and since we're in
    // one and same build method, this will never change while we are in
    // the build method
    final mediaQuery = MediaQuery.of(context);
    // orientation is recalculated for every time build() run
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Flutter App',
        //style: TextStyle(fontFamily: 'OpenSancs'),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _startAddNewTransaction(ctx);
          },
          icon: Icon(Icons.add),
          //color: Colors.red,
        ),
      ],
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top
          //MediaQuery.of(context).padding.top gives height of the status bar
          ) *
          0.6,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    var chartHeight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.3;
    var txListHeight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.6;
    print('**** Height of the tx List: **********');
    print(txListHeight);
    print('**** Height of the chart *******');
    print(chartHeight);
    print('***********************');
    return Scaffold(
      // Why I am storing the appbar in a variable?
      // because the appBar object, which I can access anywhere since it's
      // sotred in that variable, has the information about the height of
      // the appBar
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //Require the children to fill the cross axis
              children: <Widget>[
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Show Chart'),
                      Switch.adaptive(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: _showChart, // reflect what the user choosed
                        onChanged: (val) {
                          // Flutter automatically tells you should the new
                          // value be true or is it false depending on whether
                          // the switch is turned on or turned off
                          setState(() {
                            _showChart = val;
                          });
                        },
                      )
                    ],
                  ),
                //Chart() needs recent transaction not all transaction
                //we want transactions from the last week
                if (!isLandscape)
                  Container(
                    // app.preferredSize is property that get the height that is reserved
                    // their.
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransaction),
                  ),
                if (!isLandscape) txListWidget,
                //
                //
                //
                if (isLandscape)
                  _showChart
                      ? Container(
                          // appBar.preferredSize is property that get the height that is reserved
                          // their.
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: Chart(_recentTransaction))
                      // UserTransactions(),
                      : txListWidget
              ]),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(ctx);
        },
      ),
    );
  }
}
