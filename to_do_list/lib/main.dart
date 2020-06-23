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

  Widget event_display(){
    print("hbasb");
    return FutureBuilder(
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
          return Center(child: Text("No table"));
        }
        print(snapshot.data.length);
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context , int index){
              print(snapshot.data[index].event);
              return Card(
                child: Column(
                  children: <Widget>[
                    Text(snapshot.data[index].event,
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
      },
      future: dbh.event_to_list(),
    );
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
      body: event_display(),
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
