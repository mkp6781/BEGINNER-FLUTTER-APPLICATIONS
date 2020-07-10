import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_event.dart';
import 'database_class.dart';
import 'dart:async';

void main() =>  runApp(MaterialApp(
  initialRoute: '/',
  routes: <String , WidgetBuilder >{
    '/':(BuildContext context) => eventPlanner()
  },
 )
);

class eventPlanner extends StatefulWidget{
  @override
  _eventPlannerState createState()=> _eventPlannerState();
}

class _eventPlannerState extends State<eventPlanner> {
  Future<List<Map<String,dynamic>>> eventDisplay() async{
    var resmap = await database_helper.db.get_event();
    print(resmap.runtimeType);
    return resmap;
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
        future: eventDisplay(),
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
              {
                if (eventdata.data == null) {
                  break;
                }
              }
              return ListView.builder(
                  itemCount: eventdata.data.length,
                  itemBuilder: (BuildContext context , int index) {
                    table_helper _event = table_helper.fromMap(eventdata.data[index]);
                    print(_event.event);
                    var date = DateTime.parse(_event.date);
                    return Card(
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            Text("${_event.event.toUpperCase()}",
                              style: TextStyle(
                                  color: Colors.yellow[700],
                                fontSize: 20
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text("EVENT DATE: ${date.day}-${date.month}-${date.year}",
                              style: TextStyle(
                                  color: Colors.yellow[700]
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text("EVENT TIME: ${_event.time.substring(10,15)} hrs",
                              style: TextStyle(
                                  color: Colors.yellow[700]
                              ),
                            ),
                            SizedBox(height: 8,),
                          ],
                        ),
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
