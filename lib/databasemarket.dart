import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<int> datalenght() async {
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

  return (maps.length);
}

Future<List<Market>> markets() async {
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
  return List.generate(maps.length, (i) {
    return Market(
      id: maps[i]['id'],
      market: maps[i]['market'],
      mdescription: maps[i]['mdescription'],
      ticket: maps[i]['ticket'],
      tdescription: maps[i]['tdescription'],
    );
  });
}

class Market {
  final int id;
  final String market;
  final String mdescription;
  final String ticket;
  final String tdescription;

  Market({this.id, this.market, this.mdescription, this.ticket, this.tdescription});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'market': market,
      'mdescription': mdescription,
      'ticket': ticket,
      'tdescription': tdescription,
    };
  }
  @override
  String toString() {
    return 'Market{id: $id, market: $market, mdescription: $mdescription, ticket: $ticket, tdescription: $tdescription}';
  }
}