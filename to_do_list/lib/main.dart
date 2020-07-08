import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_event.dart';
import 'database_class.dart';
import 'dart:async';

void main() =>  runApp(MaterialApp(
  home: eventPlanner(),
 )
);

class eventPlanner extends StatefulWidget{
  @override
  _eventPlannerState createState()=> _eventPlannerState();
}

class _eventPlannerState extends State<eventPlanner> {
  Map<String,dynamic> newEvent = {};
  Future events;
  Future<List<Map<String,dynamic>>> eventDisplay() async{
    var resmap = await database_helper.db.get_event();
    print(resmap.runtimeType);
    return resmap;
  }

  @override
  void initState() {
    super.initState();
    events = eventDisplay();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO LIST",
          style: TextStyle(
              color: Colors.black,
              fontSize: 19
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: FutureBuilder(
        future: events,
        builder: (context , eventdata){
          switch (eventdata.connectionState){
            case ConnectionState.none:
              return Container(
                child: Text("NO DATA"),
              );
            case ConnectionState.waiting:
              return Container(
                child: Text("WAITING"),
              );
            case ConnectionState.active:
              return Container(
                child: Text("ACTIVE"),
              );
            case ConnectionState.done:
              if(!newEvent.containsKey('DATE')) {
                if(eventdata.data == null){
                  break;
                }
                newEvent = Map<String, dynamic>.from(eventdata.data);
              }
              print(eventdata.data.length);
              return ListView.builder(
                  itemCount: eventdata.data.length,
                  itemBuilder: (BuildContext context , int index) {
                    print(eventdata.data[index]);
                    table_helper _event = table_helper.fromMap(eventdata.data[index]);
                    print(_event.event);
                    var date = DateTime.parse(_event.date);
                    return Card(
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Column(
                        children: <Widget>[
                          Text(_event.event,
                            style: TextStyle(
                                color: Colors.yellow[700]
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(_event.date,
                            style: TextStyle(
                                color: Colors.yellow[700]
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(_event.time,
                            style: TextStyle(
                                color: Colors.yellow[700]
                            ),
                          ),
                          SizedBox(height: 8,),
                        ],
                      ),
                    );
                  }
              );
            }
            return Container(
                child: Center(
                  child: Text(
                    "YOU HAVE NO ACTIVITIES PLANNED",
                    style: TextStyle(
                        color: Colors.yellow[700]
                    ),
                  ),
                ),
            );

          }
        ),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[900],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addEvent()));
        },
        child: Icon(
          Icons.alarm_add,
          size: 30,
          color: Colors.yellow[700],
        ),
      ),
    );
  }
}
    // OR IN ONE LINE USING ARROW
////          Column(
////           children: eventlist.map((object) => object_card(
////                object: object,
////                delete: (){
////                  setState(() {
////                    eventlist.remove(object);
////                  });
////                },
////              )
////              ).toList(),
////          )
