import 'package:flutter/material.dart';
import 'dart:async';
import 'databasemarket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'mycreatorsize3.dart';

class MyCreatorSize2 extends StatefulWidget {
  final String marketname;

  const MyCreatorSize2({Key key, this.marketname}): super(key: key);

  @override
  _MyCreatorSize2State createState() => _MyCreatorSize2State();
}

class _MyCreatorSize2State extends State<MyCreatorSize2> {
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

    int len = 0;
    int pos = 0;
    final Database db = await database;
    final String market = widget.marketname;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM markets WHERE ticket is not NULL',);
    for (int i = 0; i < maps.length; i++) {
      if (maps[i]['market'] == market) {
        len = len + 1;
      }
    }
    List<Market> list = new List(len);
    for (int i = 0; pos != len && i < maps.length; i++) {
      if (maps[i]['market'] == market && maps[i]['ticket'] != null && maps[i]['ticket'] != "") {
        list[pos] = new Market(id: maps[i]['id'],
          market: maps[i]['market'],
          mdescription: maps[i]['mdescription'],
          ticket: maps[i]['ticket'],
          tdescription: maps[i]['tdescription'],);
        pos++;
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Choisir le Bon")),
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
                      title: Text(snapshot.data[index].ticket),
                      subtitle: Text(snapshot.data[index].tdescription),
                      onTap: (){
                        var route = new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new MyCreatorSize3(marketname: widget.marketname, ticket: snapshot.data[index].ticket, tdescription: snapshot.data[index].tdescription,),
                        );
                        Navigator.of(context).push(route);
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