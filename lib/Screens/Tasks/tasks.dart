import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String _taskOnePhrases = 'Drag take 1 to here';
  String _taskTwoPhrases = 'Drag task 2 to here';
  String _taskThreePhrases = 'Drag task 3 to here';
  String _taskOneComplete = '';
  String _taskTwoComplete = '';
  String _taskThreeComplete = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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

            // This code block is for draggable task 1
            Draggable<Task>(
                data: _allTasks[0],
                feedback: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[500],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('1. ' + _allTasks[0].name,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue[900],
                              decoration: TextDecoration.none)))),
                childWhenDragging: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('1. ' + _allTasks[0].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900])))),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('1. ' + _allTasks[0].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900]))))),

            // This code is a divider space
            //const Divider(thickness: 1, color: Colors.white),

            // This code block is for dragable item 2
            Draggable<Task>(
                data: _allTasks[1],
                feedback: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[500],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('2. ' + _allTasks[1].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900],
                                decoration: TextDecoration.none)))),
                childWhenDragging: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('2. ' + _allTasks[1].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900])))),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('2. ' + _allTasks[1].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900]))))),

            // This code is a divider space
            //const Divider(thickness: 1, color: Colors.white),

            // This code block is for draggable task 3
            Draggable<Task>(
                data: _allTasks[2],
                feedback: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[500],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('3. ' + _allTasks[2].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900],
                                decoration: TextDecoration.none)))),
                childWhenDragging: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('3. ' + _allTasks[2].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900])))),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(Radius.circular(10) )
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('3. ' + _allTasks[2].name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue[900]))))),

            //  This code is a divider line
            const Divider(thickness: 5, color: Colors.grey),

            // This code block is a label
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

            // This code block is a tappable drag target for task 1
            InkWell(
                // On double tap reset task 2 phrase
                onDoubleTap: () {
                  setState(() {
                    _taskOnePhrases = 'Drag task 1 to here';
                    _taskOneComplete = '';
                  });
                },
                child: DragTarget<Task>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.lightBlue[100],
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.all(Radius.circular(10) )
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('$_taskOneComplete' + '$_taskOnePhrases',  // Sets the drag target to the task 1 completed
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[900]))));
                  },
                  onAccept: (Task data) {
                    debugPrint('Check Name: ' + data.name);
                    if (data.name == 'Brush your teeth') {
                      setState(() {
                        // When dropping task 1 set task's phrase to its class data value
                        _taskOnePhrases = data.name;
                        _taskOneComplete = 'Completed: ';
                      });
                    } else {
                      // If not dropping task 1 then run popup message
                      taskPopUpMethod(context, 'This space is reserved for task 1');
                    }
                  },
                )),

            // This code is a divider space
            //const Divider(thickness: 1, color: Colors.white),

            // This code block is a tappable drag target for task 2
            InkWell(
                // On double tap reset task 2 phrase
                onDoubleTap: () {
                  setState(() {
                    _taskTwoPhrases = 'Drag task 2 to here';
                    _taskTwoComplete = '';
                  });
                },
                child: DragTarget<Task>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.all(Radius.circular(10) )
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('$_taskTwoComplete' + '$_taskTwoPhrases',  // Sets the drag target to the task 2 completed
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[900]))));
                  },
                  onAccept: (Task data) {
                    debugPrint('Check Name: ' + data.name);
                    if (data.name == 'Go for a walk') {
                      setState(() {
                        // When dropping task 2 set task's phrase to its class data value
                        _taskTwoPhrases = data.name;
                        _taskTwoComplete = 'Completed: ';
                      });
                    } else {
                      // If not dropping task 2 then run popup message
                      taskPopUpMethod(context, 'This space is reserved for task 2');
                    }
                  },
                )),

            // This code is a divider space
            //const Divider(thickness: 1, color: Colors.white),

            // This code block is a tappable drag target for task 3
            InkWell(
                // On double tap reset the task 3 phrase
                onDoubleTap: () {
                  setState(() {
                    _taskThreePhrases = 'Drag task 3 to here';
                    _taskThreeComplete = '';
                  });
                },
                child: DragTarget<Task>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.all(Radius.circular(10) )
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text('$_taskThreeComplete' + '$_taskThreePhrases',  // Sets the drag target to the task 3 completed
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue[900]))));
                  },
                  onAccept: (Task data) {
                    debugPrint('Check Name: ' + data.name);
                    if (data.name == 'Drink your water') {
                      setState(() {
                        // When dropping task 3 set task's phrase to its class data value
                        _taskThreePhrases = data.name;
                        _taskThreeComplete = 'Completed: ';
                      });
                    } else {
                      // If not dropping task 3 run popup message
                      taskPopUpMethod(context, 'This space is reserved for task 3');
                    }
                  },
                )
              ),

            // This code is a label
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Double Tap to Remove a Completed Task',
                style: TextStyle(
                    fontSize: 18.0,
                    //fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[900]),
              ),
            ),
          ]),
    );
  }
}

// Basic class code.
class Task {
  const Task({
    required this.name,
  });
  final String name;
}

// List of tasks
const List<Task> _allTasks = [
  Task(name: 'Brush your teeth'),
  Task(name: 'Go for a walk'),
  Task(name: 'Drink your water')
];

// Method that takes the context and a string message and produces an alert in the app.
void taskPopUpMethod(BuildContext myContext, String str) {
  showDialog<String>(
      context: myContext,
      builder: (BuildContext myContext) => AlertDialog(
            title: const Text('Alert'),
            content: Text(str),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(myContext, 'Cancel'),
                child: const Text('OK'),
              ),
            ],
          ));
}
