import 'package:flutter/material.dart';
import 'object_card.dart';
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

  List<table_helper> eventlist = [];
  database_helper dbh = database_helper();
  int id=1;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            child: Text("DISPLAY"),
            onPressed: () async{
                eventlist = await dbh.event_to_list();
              }
            ),
          SizedBox(height: 8 ),
          ListView.builder(
            itemCount: eventlist.length,
            itemBuilder: (BuildContext context , int index){
            return Card(
              child: Column(
                children: <Widget>[
                  Text(eventlist[index].event,
                    style: TextStyle(
                        color: Colors.yellow
                    ),
                  ) ,
                  SizedBox(height: 8),
                  Text(eventlist[index].time ,
                  style: TextStyle(
                    color: Colors.yellow
                  ),
                  ),
                  SizedBox(height: 8),
                  Text(eventlist[index].date,
                    style: TextStyle(
                        color: Colors.yellow
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
        )
      ]
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


//Column(
//children: eventlist.map((e) => object_card(
//object: e,
//delete: (){
//eventlist.remove(e);
//}
//)).toList()
//);

////          // OR IN ONE LINE USING ARROW
//////          Column(
//////            children: eventlist.map((object) => object_card(
//////                object: object,
//////                delete: (){
//////                  setState(() {
//////                    eventlist.remove(object);
//////                  });
//////                },
//////              )
//////              ).toList(),
//////          )
