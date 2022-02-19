import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class Tasks extends StatefulWidget{
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}
class _TasksState extends State<Tasks>{
  String _myTaskPhrase = 'Drag to here';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Tasks',
                style: TextStyle(fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[900])
        ),
        centerTitle: false,
        backgroundColor: Colors.lightBlue[100],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(15.0),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '--Task--',
              ),
          ),
          ),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Active Tasks',
              style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[900]),
            ),

          ),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(_allTasks[0].name,
              style: TextStyle(fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[900],
              decoration: TextDecoration.none)

            )
          ),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(_allTasks[1].name,
              style: TextStyle(fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[900],
              decoration: TextDecoration.none)

            )
          ),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(_allTasks[2].name,
              style: TextStyle(fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[900],
              decoration: TextDecoration.none)

            )
          ),


          const Divider(thickness: 5, color: Colors.grey),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Completed Tasks',
              style: TextStyle(fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[900]),
            ),

          ),


        ]

        ),

      );
  }
}
class Task{
  const Task({
    required this.name,
  });
  final String name;
}
const List<Task> _allTasks = [
  Task(name: 'Task 1 to be completed'),
  Task(name: 'Task 2 to be completed'),
  Task(name: 'Task 3 to be completed')
];