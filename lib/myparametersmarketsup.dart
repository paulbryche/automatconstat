import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'databasemarket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyParamsMarketSup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Gestion des marchés")),
      body: new Container(color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 250,
                height: 70,
                child: new Text("Numéro de marché:",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 250,
                height: 60,
                child: MyStatefulWidget(),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 240,
                height: 60,
                child: new RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Supprimer',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                  onPressed: () {supmarket(marketnumber, context);},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void supmarket(marketnumber, context) {

    _supmarket(marketnumber).then((bool commited) {
      Navigator.pop(context,true);});
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Choisir';
  Future<List<Market>> marketlist = markets();
  List<String> item = getnumber();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 60,
          color: Colors.grey,
          child: Center(
            child: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey,),
              child: DropdownButton<String>(
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
                iconSize: 60,
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Choisir', 'ONE', 'TWO', 'THREE', 'FOUR']
                    .map<DropdownMenuItem<String>>((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
//                        child: new Container(
//                          color: Colors.grey,
                    child: Text(value,
                      style: new TextStyle(backgroundColor: Colors.grey,
                          color: Colors.white,
                          fontSize: 25),),
//                        ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> getmarketnumber() {
  var items = new List<String>();
  for (var contact in _contacts){
    items.add(new String(contact));
  }
  return items;
}

Future<bool> _supmarket(String marketnumber) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'markets_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE markets(id INTEGER PRIMARY KEY, market TEXT, mdescription TEXT, ticket TEXT,tdescription TEXT)",
      );
    },
    version: 1,
  );
  if (marketnumber != null && marketnumber != "") {
    final db = await database;

    await db.delete(
      'markets',
      where: "market = ?",
      whereArgs: [marketnumber],
    );
  }
  print(await markets());
  return true;
}