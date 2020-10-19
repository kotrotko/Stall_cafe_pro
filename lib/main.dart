import 'package:flutter/material.dart';
import 'package:stall_cafe_pro/src/prefs_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './src/date_time.dart';
import './src/allergy_button.dart';
import './src/dish_price.dart';

//this is stall_cafe_pro
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
        DishDescriptionPage.routeName: (context) => DishDescriptionPage(),
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
              title: Text('Home'),
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
              title: Text('Menu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
            ListTile(
              title: Text('Order'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Dish Description'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DishDescriptionPage(),
                  ),
                );
              },
            ),
          ]),
        ),
        body: Column(children: <Widget>[
          Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            Container(
              child: Image.asset('assets/images/jagersro.jpg'),
            ),
            FractionalTranslation(
              translation: Offset(0.0, 0.5),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 36,
                //decoration: BoxDecoration(color: Colors.white),
                child: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: Text(
              "Stallcafe",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            //padding: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: OpenHours(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
            child: Text(
              "Ringa oss:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
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
          Expanded(
            child: Text(
              "Välkommen",
              style: TextStyle(fontSize: 20),
            ),
            //padding: EdgeInsets.all(15.0),
          ),
          Container(
            padding: EdgeInsets.only(top: 6.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
            child: MenuWeek(),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
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
    'Enchilada',
    'Taco Bowl',
    'Pico de Gallo',
  ];

  List<String> order = [];

  @override
  Widget build(BuildContext context) {
    getOrder().then((value) => {
          setState(() {
            order = value;
          })
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Jägersro",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Text("Menu", style: TextStyle(fontSize: 30.0)),
          alignment: Alignment.center,
        ),
        Container(
          child: Center(
            child: Text("touch a heart and make your order ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
        ),
        Container(
          child: Center(
            child: Text("now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0)),
          ),
        ),
        Center(child: MenuDateTime()),
        Expanded(
            child: ListView.builder(
                itemCount: _dishMenu.length,
                itemBuilder: (context, int index) {
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
                              print(currentOrderEntries);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () async {
                              List<String> currentOrderEntries =
                                  await getOrder();
                              currentOrderEntries.add(_dishMenu[index]);
                              saveOrder(currentOrderEntries);
                              print(currentOrderEntries);
                            }),
                  );
                })),
      ]),
    );
  }
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
    getOrder().then((value) => {
          setState(() {
            order = value;
          })
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Jägersro",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Text("My Order", style: TextStyle(fontSize: 30.0)),
          //alignment: Alignment.center,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: order.length,
              itemBuilder: (context, int i) {
                return ListTile(
                  title: Text(order[i]),
                  trailing: Icon(Icons.favorite, color: Colors.blue),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {},
                child: Text('SUBMIT'),
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                },
                child: Text('CANCEL'),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class DishDescriptionPage extends StatefulWidget {
  static const routeName = 'dishDescriptionPage';

  @override
  _DishDescriptionPageState createState() => _DishDescriptionPageState();
}

class _DishDescriptionPageState extends State<DishDescriptionPage> {
  List<String> _dishMenu = [
    'Enchilada',
  ];

  List<String> order = [];

  @override
  Widget build(BuildContext context) {
    getOrder().then((value) => {
          setState(() {
            order = value;
          })
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Jägersro",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Text("Dishes", style: TextStyle(fontSize: 30.0)),
          alignment: Alignment.center,
        ),
        Container(
          height: 200.0,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('assets/images/enchilada.jpg'),
            ),
          ),
        ),
        Column(children: <Widget>[
          // "Enchilada"
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.0)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enchilada",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
              12.0,
              8.0,
              0,
              0,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Chile sauce, tortillas, beans, onion, cheddar",
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
              12.0,
              8.0,
              0,
              0,
            ),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Optionally: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                TextSpan(
                  text: 'beef, chicken, vegetarian',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.0)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(12.0, 8.0, 0, 8.0),
                    child: Text("Order now             ",
                        style: TextStyle(fontSize: 20.0)),
                  ),
                  Container(
                    child: order.contains(_dishMenu[0])
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              List<String> currentOrderEntries =
                                  await getOrder();
                              currentOrderEntries.remove(_dishMenu[0]);
                              saveOrder(currentOrderEntries);
                              print(currentOrderEntries);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () async {
                              List<String> currentOrderEntries =
                                  await getOrder();
                              currentOrderEntries.add(_dishMenu[0]);
                              saveOrder(currentOrderEntries);
                              print(currentOrderEntries);
                            }),
                  ),
                ]),
          ),
          Container(
            child: AllergyButton(),
          ),
          Container(
            child: DishPrice(),
          ),
        ]),
      ]),
    );
  }
}
