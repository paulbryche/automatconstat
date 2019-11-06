import 'package:flutter/material.dart';
import 'dart:async';
import 'databasemarket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyParamsTicketAdd extends StatefulWidget {
  @override
  MyParamsTicketAddState createState() => new MyParamsTicketAddState();
}

class MyParamsTicketAddState extends State<MyParamsTicketAdd> {

  List data;

  Future<List<Market>> getmarkets() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'markets_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE markets(id INTEGER PRIMARY KEY, market TEXT, mdescription TEXT, ticket TEXT,tdescription TEXT)",
        );
      },
      version: 1,
    );
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM markets WHERE ticket is NULL');
    return List<Market>.generate(maps.length, (int index) => Market(
      id: maps[index]['id'],
      market: maps[index]['market'],
      mdescription: maps[index]['mdescription'],
      ticket: maps[index]['ticket'],
      tdescription: maps[index]['tdescription'],
    ), growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Choisir le Marché")),
        body: Container (
          child: FutureBuilder(
            future: getmarkets(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return Container (
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].market),
                      subtitle: Text(snapshot.data[index].mdescription),
                      onTap: (){
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new MyParamsTicketCreateEnd(marketname: snapshot.data[index].market),
                        );
                        Navigator.of(context).push(route).then((bool) {Navigator.pop(context,true);});

                      },
                    );
                  },
                );
              }
            },
          ),
        )
    );
  }
}

class MyParamsTicketCreateEnd extends StatefulWidget {
  final String marketname;

  const MyParamsTicketCreateEnd({Key key, this.marketname}): super(key: key);

  @override
  _MyParamsTicketCreateEndState createState() => _MyParamsTicketCreateEndState();
}

class _MyParamsTicketCreateEndState extends State<MyParamsTicketCreateEnd> {
  var number = TextEditingController();
  var ope = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Numéros de Bons")),
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
                height: 60,
                child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                  controller: number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Numéro de Bons'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),),
                width: 280,
                height: 60,
                child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 25),
                  controller: ope,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 6.0),
                      ),
                      hintText: 'Opération liée'
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 290,
                height: 120,
                child: new RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Ajouter un numéro \nde marché',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 30),),
                  onPressed: () {saveticket(context);
                  return true;},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveticket(context) {
    String _number = number.text;
    String _ope = ope.text;
    _saveticket(widget.marketname, _number, _ope).then((bool commited) {
      Navigator.pop(context,true);});
  }
}

Future<bool> _saveticket(String market, String number, String ope) async {

  final database = openDatabase(
    join(await getDatabasesPath(), 'markets_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE markets(id INTEGER PRIMARY KEY, market TEXT, mdescription TEXT, ticket TEXT,tdescription TEXT)",
      );
    },
    version: 1,
  );

  Future<void> insertMarket(Market market) async {
    final Database db = await database;

    await db.insert(
      'markets',
      market.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  if (number != null && number != "" && ope != null && ope != "") {
    var mymarket = Market(
      id: await datalenght() + 1,
      market: '$market',
      mdescription: null,
      ticket: '$number',
      tdescription: "$ope",
    );
    await insertMarket(mymarket);
  }
  return true;
}