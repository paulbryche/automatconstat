import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'databasemarket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyParamsMarketSup extends StatefulWidget {
  @override
  MyParamsMarketSupState createState() => new MyParamsMarketSupState();
}

class MyParamsMarketSupState extends State<MyParamsMarketSup> {

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
    final List<Map<String, dynamic>> maps = await db.query('markets');
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
      appBar: AppBar(backgroundColor: Colors.redAccent, title: Text("Gestion des marchés")),
      body: Container (
        child: FutureBuilder(
          future: getmarkets(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container (
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.lenght,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].market),
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
/*
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
*/