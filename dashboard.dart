import 'package:flutter/material.dart';
import 'form.dart';
import 'form.1.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int screen = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('DIGI MERCHANTS - ABC Group'),
        ),
        drawer: new Drawer(

            child: new Column(children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                    " ",
                    style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0)
                ),



                currentAccountPicture: new CircleAvatar(
                    backgroundColor: Colors.brown, child:  Image.asset('assets/logo.png'),

                ),

              ),
              new ListTile(
                title: new Text('DASHBOARD'),
                leading: Icon(Icons.dashboard),
                onTap: () {
                  this.setState(() {
                    screen = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                title: new Text('SYSTEM MANAGEMENT'),
                  leading: Icon(Icons.settings),
                onTap: () {
                  this.setState(() {
                    screen = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('REPORTS'),
                leading: Icon(Icons.auto_awesome_mosaic),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]
            )
        ),
        body: (
            screen == 0 ? new FormScreen() : new Dashboard()
        )
    );
  }
}