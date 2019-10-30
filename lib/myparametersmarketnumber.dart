import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'myparametersmarketsup.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'databasemarket.dart';

class MyParamsMarketNum extends StatefulWidget {
  @override
  _MyParamsMarketNumState createState() => _MyParamsMarketNumState();
}

class _MyParamsMarketNumState extends State<MyParamsMarketNum> {
  var number = TextEditingController();
  var ope = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Numéros de marché")),
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
                      hintText: 'Numéro de Marché'
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
                    onPressed: () {savemarket(context);},
                ),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Container(
                padding: EdgeInsets.only(top: 24),
                width: 280,
                height: 120,
                child: new RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('Gérer mes numéros de bon de commande',
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 25),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyParamsMarketSup()),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savemarket(context) {
    String _number = number.text;
    String _ope = ope.text;
    _savemarket(_number, _ope).then((bool commited) {
      Navigator.pop(context,true);});
  }
}
Future<bool> _savemarket(String number, String ope) async {

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
      market: '$number',
      mdescription: "$ope",
      ticket: null,
      tdescription: null,
    );
    await insertMarket(mymarket);
  }
  return true;
}