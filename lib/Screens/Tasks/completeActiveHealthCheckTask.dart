import 'package:flutter/material.dart';

class ActiveHealthCheckTask extends StatefulWidget {
  const ActiveHealthCheckTask({Key? key}) : super(key: key);

  @override
  _ActiveHealthCheckTaskState createState() => _ActiveHealthCheckTaskState();
}

class _ActiveHealthCheckTaskState extends State<ActiveHealthCheckTask> {
  String pageToDisplay = 'first';
  String firstAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (pageToDisplay == 'first')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('How are you feeling?',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700)),
                  Text('Let the staff know how you are feeling today.',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  Row(
                    children: <Widget>[
                      // Expanded(
                      // child:
                      Column(
                        children: <Widget>[
                          IconButton(
                              iconSize: 100.0,
                              icon: Icon(Icons.emoji_emotions_outlined,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  firstAnswer = "Bad";
                                  pageToDisplay = 'second';
                                });
                                print('First Answer Selected $firstAnswer');
                              }
                              // padding: EdgeInsets.zero,
                              ),
                          Text('Bad')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 100.0,
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                firstAnswer = "Okay";
                                pageToDisplay = 'second';
                              });
                              print('First Answer Selected $firstAnswer');
                            },
                            // padding: EdgeInsets.zero,
                          ),
                          Text('Okay')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 100.0,
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                firstAnswer = "Good";
                                pageToDisplay = 'second';
                              });
                              print('First Answer Selected $firstAnswer');
                            },
                            // padding: EdgeInsets.zero,
                          ),
                          Text('Good')
                        ],
                      ),
                    ],
                  )
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('pg 2',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700)),
                  Text('Let the staff know how you are feeling today.',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  Row(
                    children: <Widget>[
                      // Expanded(
                      // child:
                      Column(
                        children: <Widget>[
                          IconButton(
                              iconSize: 100.0,
                              icon: Icon(Icons.emoji_emotions_outlined,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  firstAnswer = "Bad";
                                });
                                print('First Answer Selected $firstAnswer');
                              }
                              // padding: EdgeInsets.zero,
                              ),
                          Text('Bad')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 100.0,
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                firstAnswer = "Okay";
                              });
                              print('First Answer Selected $firstAnswer');
                            },
                            // padding: EdgeInsets.zero,
                          ),
                          Text('Okay')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            iconSize: 100.0,
                            icon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                firstAnswer = "Good";
                              });
                              print('First Answer Selected $firstAnswer');
                            },
                            // padding: EdgeInsets.zero,
                          ),
                          Text('Good')
                        ],
                      ),
                      // ),
                      // Expanded(
                      //   child: Column(
                      //     children: <Widget>[
                      //       Icon(Icons.emoji_emotions_outlined,
                      //           size: 100.0, color: Colors.blue),
                      //       Text('Okay')
                      //     ],
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Column(
                      //     children: <Widget>[
                      //       Icon(Icons.emoji_emotions_outlined,
                      //           size: 100.0, color: Colors.green),
                      //       Text('Great')
                      //     ],
                      //   ),
                      // )
                    ],
                  )
                ],
              )
          ],
        ));
  }
}
