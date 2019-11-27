import 'package:flutter/material.dart';
import 'dart:async';
import 'databasemarket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'mycreatorsize2.dart';


class MyCreatorSize extends StatefulWidget {
  @override
  MyCreatorSizeState createState() => new MyCreatorSizeState();
}

class MyCreatorSizeState extends State<MyCreatorSize> {
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
    await db.close();
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
        appBar: AppBar(backgroundColor: Colors.pinkAccent, title: Text("Choisir le Marché")),
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
                          new MyCreatorSize2(marketname: snapshot.data[index].market),
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