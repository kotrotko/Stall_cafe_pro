import 'package:flutter/material.dart';
import 'package:stall_cafe_pro/src/prefs_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        MenuPage.routeName: (context) => MenuPage(),
        OrderPage.routeName: (context) => OrderPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            "Jägersro",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('HomePage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Menu Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
            ListTile(
              title: Text('Order Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(),
                  ),
                );
              },
            ),
          ]),
        ),
        body: Column(children: <Widget>[
          Container(
            child: Image.asset('assets/images/jagersro.jpg'),
          ),
          Container(
            child: Icon(
              Icons.restaurant_menu,
              color: Colors.blue,
              size: 40,
            ),
          ),
          Container(
            child: Text(
              "Stallcafe",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            padding: EdgeInsets.all(5.0),
          ),
          Container(
            child: Text("Öppnad",
                style: TextStyle(
                  fontSize: 20,
                )),
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            child: Text(
              "Ringa oss:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: FlatButton(
              textColor: Colors.blue,
              splashColor: Colors.blueAccent,
              onPressed: () => launch("tel:+0721371754"),
              child: Text(
                "0721371754",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Container(
            child: Text(
              "Välkommen",
              style: TextStyle(fontSize: 20),
            ),
            padding: EdgeInsets.all(15.0),
          ),
          Container(
            child: Text(
              "LUNCHMENY V.27",
              style: TextStyle(color: Colors.blue),
            ),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Följ oss på Facebook:",
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
                FlatButton(
                  child: Icon(
                    MdiIcons.facebook,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () async {
                    const url = 'https://www.facebook.com/jagersrotrav/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Kunde inte hitta $url';
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  static const routeName = 'menuPage';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> _dishMenu = [
    'Enchilada Chicken',
    'Taco Bowl',
    'Pico de Gallo',
  ];
  List<String> order = [];

  @override
  Widget build(BuildContext context) {
    getOrder().then((value) => {setState((){order=value;})});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Jägersro",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
      body: Column(children: <Widget>[
        Container(
          child: Text("Menu", style: TextStyle(fontSize: 30.0)),
          alignment: Alignment.center,
        ),
        Container(
          child: Center(
            child: Text("touch a heart and make your order now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ),
        ),
        Container(
          child: Text("Date"),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_dishMenu[index]),
                    trailing: order.contains(_dishMenu[index])
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              List<String> currentOrderEntries =
                                  await getOrder();
                              currentOrderEntries.remove(_dishMenu[index]);
                              saveOrder(currentOrderEntries);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () async {
                              List<String> currentOrderEntries =
                                  await getOrder();
                              currentOrderEntries.add(_dishMenu[index]);
                              saveOrder(currentOrderEntries);
                            }),
                  );
                })),
      ]),
    );
  }

  //
}

class OrderPage extends StatefulWidget {
  static const routeName = 'orderPage';

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> order = [];

  @override
  Widget build(BuildContext context) {
    getOrder().then((value) => {setState(() {order=value;})});
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          //title: Text(args.title),
          title: const Text("Jägersro",
              style: TextStyle(color: Colors.white, fontSize: 30.0)),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: order.length,
                  itemBuilder: (context, int i) {
                    return Text(order[i]);
                    //return ListTile(title: args.text, trailing: args.icon);
                  }),
            ),
          ],
        ));
  }
}

class ScreenArguments {
  final Icon icon;
  final Text text;

  ScreenArguments(this.icon, this.text);
}
