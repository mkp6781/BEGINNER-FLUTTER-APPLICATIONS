import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';

final String tablename = "EVENT_SCHEDULE";
final String col_1 = "id";
final String col_2 = "EVENT";
final String col_3 = "DATE";
final String col_4 = "TIME";

class table_helper {
  String event;
  String date;
  String time;
  int id;
  
  table_helper({this.id, this.event , this.date, this.time});

  Map<String, dynamic> toMap() {
    Map<String,dynamic> map = <String , dynamic>{
      col_2: event,
      col_3: date,
      col_4: time
    };
    return map;
  }

  table_helper.fromMap(Map<String , dynamic> map){
    id = map[col_1];
    event = map[col_2];
    date = map[col_3];
    time = map[col_4];
  }
}

class database_helper {
  database_helper._();
  static final database_helper db = database_helper._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await init_database();
    return _database;
  }

  Future<Database> init_database() async {
    print("initialising database");
    return await openDatabase(
      join(await getDatabasesPath(), "event_schedule.db"),
      version: 1,
      onCreate: (db, version) {
        return db.execute("CREATE TABLE IF NOT EXISTS $tablename($col_1 INTEGER PRIMARY KEY AUTOINCREMENT, $col_2 TEXT , $col_3 DATE , $col_4 DATE)");
        },
    );
  }

  insert_event(table_helper table) async {
    final db = await database;
    try {
      await db.insert(tablename, table.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print("INSERTION SUCCESSFUL");
    }
    catch (_) {
      print(_);
    }
  }

  Future<List<Map<String,dynamic>>> get_event() async {
    final db = await database;
    print(db);
    List<Map<String,dynamic>> res = await db.query(tablename);
    print(res);
    if(res.length == 0){
      print("IT IS NULL");
      return null;
    }
    return res;
  }
}
//    List<table_helper> eventList = List<table_helper>();
//    res.forEach ((currentEvent) {
//      table_helper eventData = table_helper.fromMap(currentEvent);
//      eventList.add(eventData);
//    });

