import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database_class.dart';
import 'date_and_time.dart';

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
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      resizeToAvoidBottomPadding: false,
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
        padding: EdgeInsets.fromLTRB(30,30, 30, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    "Time in 24hrs: ${_time.hour}:${_time.minute}",
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
                    database_helper.db.insert_event(table);
//                    setState(() {
//                      id+= 1;
//                    });
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
