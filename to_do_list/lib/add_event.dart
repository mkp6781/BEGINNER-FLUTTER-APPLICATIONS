import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_class.dart';
import 'date_and_time.dart';
import 'dart:async';

class addEvent extends StatefulWidget {
  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  String event="";
  TextEditingController ctrl = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  table_helper table;
  Database db;
  database_helper dbh = database_helper();
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD EVENT" ,
        style: TextStyle(
        color: Colors.black,
        fontSize: 19
          ),
        ),
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30,150, 30, 75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: ctrl,
                  style: TextStyle(
                  color: Colors.yellow[700]
                ),
                  decoration: InputDecoration(hintText: "event",
                  hoverColor: Colors.yellow[700],
                  ),
                  cursorColor: Colors.yellow[700],
                  onChanged: (String text){
                    setState(() {
                      event = text;
                      print("$event");
                    });
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
            ListTile(
              title: Text("DATE : ${_date.year}-${_date.month}-${_date.day}",
                style: TextStyle(
                  color: Colors.yellow[700]
                ),
              ),
              trailing: Icon(
                Icons.calendar_today,
                color: Colors.yellow[700],
              ),
            ),
            ListTile(
              title: Text(
                "TIME : ${_time.hour}:${_time.minute}",
                style: TextStyle(
                    color: Colors.yellow[700]
                ),
              ),
              trailing: Icon(
                Icons.access_time,
                color: Colors.yellow[700],
              ),
            ),
            FlatButton.icon(
                onPressed: () async{
                  DateTime pickeddate = await select_date(context , _date);
                  TimeOfDay pickedtime = await select_time(context, _time);
                  setState(() {
                    if (pickeddate != null)
                      _date = pickeddate;

                    if(pickedtime != null)
                      _time =pickedtime;
                  });
                },
                icon: Icon(
                  Icons.access_time,
                  color: Colors.yellow[700],
                ),
                label: Text("Pick Date and Time",
                style: TextStyle(
                color: Colors.yellow[700]
                ),
                ),
            ),
            SizedBox(height: 50),
            FlatButton(
              onPressed: (){
                table = table_helper(event: event , date: _date.toIso8601String() , time: _time.toString(), id: id);
                setState(() {
                  id+= 1;
                  dbh.insert_event(table);
                });
                print("INSERTION SUCCESSFUL");
                ctrl.clear();
                Navigator.pop(context);
              },
              child: Text("SET REMINDER",
              style: TextStyle(
                fontSize: 20,
              color: Colors.yellow[700]
              ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
