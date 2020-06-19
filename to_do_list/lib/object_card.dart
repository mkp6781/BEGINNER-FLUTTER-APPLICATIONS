import 'package:todolist/database_class.dart';

import 'package:flutter/material.dart';

class object_card extends StatefulWidget {

  table_helper object;
  Function delete;
  object_card({this.object , this.delete});

  @override
  _object_cardState createState() => _object_cardState();
}

class _object_cardState extends State<object_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        color: Colors.black,
        shadowColor: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8.0 ,0 , 0, 0),
              child: Text(
                widget.object.event,
                style: TextStyle(
                    color: Colors.yellow,
                    letterSpacing: 1.5
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0 ,0 ,0),
              child: Text(
                widget.object.date.toString(),
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: widget.delete,
                    icon: Icon(
                        Icons.delete,
                      color: Colors.green,
                    ),
                    label: Text("Delete",
                    style: TextStyle(
                      color: Colors.green
                    ),
                    )
                ),

                FlatButton.icon(
                    onPressed: (){
                      print("HEY");
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                    label: Text("Edit",
                      style: TextStyle(
                          color: Colors.green
                      ),
                    )
                ),
              ],
            )
          ],
        )
    );
  }
}