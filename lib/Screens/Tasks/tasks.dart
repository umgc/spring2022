import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';


class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  //Color colorOfBackground = Color(0xFFB3E5FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /*Padding(
            padding: EdgeInsets.all(15.0),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '--Task--',
              ),
          ),
          ),*/

              // This code block is a label

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Active Tasks:',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),

              // This block builds the ToDo list
              ListView.builder(
                shrinkWrap: true,
                itemCount: _toDoTasks.length,
                itemBuilder: (BuildContext context, int index){

                  return Container(
                    child: InkWell(
                      //This runs when double tapping an Active Task
                      onDoubleTap: (){
                        setState(() {

                          _completeTasks.add(_toDoTasks.elementAt(index));
                          _toDoTasks.remove(_toDoTasks.elementAt(index));

                        });
                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          //color: setBackgroundColor(index),
                          border: Border.all(color: Colors.blue),
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: <Widget>[

                              FaIcon(_toDoTasks.elementAt(index).taskIcon, color: Colors.lightBlue[900]),

                              Text(
                                ' - ' + _toDoTasks.elementAt(index).name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue[900]

                                ),
                              )
                            ]
                          )

                        )
                      )

                    )
                  );


                }
              ),



              // This block is a label
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Double Tap to Complete a Task',
                  style: TextStyle(
                      fontSize: 18.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),


              //  This code is a divider line
              const Divider(thickness: 5, color: Colors.grey),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Completed Tasks:',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),

              // This block builds the list of completed tasks
              ListView.builder(
                shrinkWrap: true,
                itemCount: _completeTasks.length,
                itemBuilder: (BuildContext context, int index){

                  return Container(
                    child: InkWell(
                      //This runs when double tapping a completed task
                      onDoubleTap: (){
                        setState(() {

                          _toDoTasks.add(_completeTasks.elementAt(index));
                          _completeTasks.remove(_completeTasks.elementAt(index));

                        });
                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Completed: ' +  _completeTasks.elementAt(index).name,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900]
                              ),
                          )
                        )

                      )

                    )
                  );


                }
              ),



              // This code is a label
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Double Tap to Reset a Completed Task',
                  style: TextStyle(
                      fontSize: 18.0,
                      //fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900]),
                ),
              ),
            ]),
      ),
    );
  }
}

// Basic class
class Task {
  const Task({
    required this.name,
    required this.taskIcon,
  });
  final String name;
  final IconData taskIcon;
}


// This is a list of active tasks
Set<Task> _toDoTasks = {
  Task(name: 'Brush your teeth', taskIcon: FontAwesomeIcons.tooth),
  Task(name: 'Go for a walk', taskIcon: FontAwesomeIcons.walking),
  Task(name: 'Drink some water', taskIcon: FontAwesomeIcons.glassWhiskey)
};

//This is a list of completed tasks
Set<Task> _completeTasks = {

};

Color setBackgroundColor(int innerIndex){

  if(_completeTasks.contains(_toDoTasks.elementAt(innerIndex))){
    return Colors.grey;
  }

  return Color(0xFFB3E5FC);


}


