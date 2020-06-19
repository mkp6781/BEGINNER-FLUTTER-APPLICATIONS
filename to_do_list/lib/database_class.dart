import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tablename = "EVENT_SCHEDULE";
final String col_1 = "id";
final String col_2 = "EVENT";
final String col_3 = "DATE";
final String col_4 = "TIME";

class table_helper {
  final String event;
  final String date;
  final String time;
  int id;
  
  table_helper({this.id, this.event , this.date, this.time});

  Map<String, dynamic> toMap() {
    return {
    col_2 : event,
    col_3 : date,
    col_4 : time};
  }
}

class database_helper {
  Database db;

  database_helper() {
    init_database();
  }

  Future<void> init_database() async{
    db= await openDatabase(
        join(await getDatabasesPath(), "event_schedule.db"),
        onCreate: (db, version) {
          return db.execute("CREATE TABLE IF NOT EXISTS $tablename($col_1 INTEGER PRIMARY KEY AUTOINCREMENT, $col_2 TEXT , $col_3 DATE , $col_4 )");
        },
        version: 1
    );
    print(db);
    print("ghs");
  }

  Future<void> insert_event(table_helper table) async {
//    db = await database;
    try{
      await db.insert(tablename, table.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
      print("INSERTION SUCCESSFUL");
    }
    catch(_){
      print(_);
    }
  }

  Future<List<table_helper>> event_to_list() async {
    print(db);
    final List<Map<String, dynamic>> event_list = await db.query(tablename);
    return List.generate(event_list.length, (i) =>
            table_helper(event: event_list[i][col_2],
            date: event_list[i][col_3],
            time: event_list[i][col_4],
        id: event_list[i][col_1]));
  }
}
//
//  Future<List<table_helper>> get_list() async{
//    return list;
//  }

//  database_helper._();
//  static final database_helper db = database_helper._();
//  static Database _database;
//  List<table_helper> list;

//  database_helper(){
//    init_database();
//  }
//  Future<Database> get database async{
//    if(_database != null)
//      return _database;
//
//    _database = init_database();
//    return _database;
//  }
