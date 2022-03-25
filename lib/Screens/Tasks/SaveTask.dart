import 'dart:ffi';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Task.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Services/TaskService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/Utility/FontUtil.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'dart:math' as math;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Task page
class SaveTask extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingTask;

  SaveTask({this.isCheckListEvent = false, this.viewExistingTask = false}) {}

  @override
  State<SaveTask> createState() => _SaveTaskState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingTask: this.viewExistingTask);
}

//__ONSAVE
class _SaveTaskState extends State<SaveTask> {
  String enteredTaskName = '';
  String enteredTaskDescription = '';
  String selectedIcon = '';
  String selectedIconColor = '';
  String selectedSchedule = '';
  String selectedDate = '';
  String selectedTime = '';
  String taskType = '';
  DateTime selectedDateTime = DateTime.now();
  // bool selectedIsResponseRequired = false;

  //these flags indicate whether or not a button has been pressed
  bool _walkingFlag = true;
  bool _utensilFlag = true;
  bool _capsulesFlag = true;
  bool _toothFlag = true;
  bool _envelopeFlag = true;
  bool _tshirtFlag = true;

  void unPressButtons() {
    _walkingFlag = true;
    _utensilFlag = true;
    _capsulesFlag = true;
    _toothFlag = true;
    _envelopeFlag = true;
    _tshirtFlag = true;
  }

  //Show & hide keyboard

  FocusNode textFocusNode = FocusNode();

  @override
  void textDispose() {
    textFocusNode.dispose();
    super.dispose();
  }

  //Index of stepper
  static int _stepIndex = 0;
  //Initial value for dropdown list
  String colorDropdownValue = 'Select Icon Color';
  //This was done to get an unfilled button
  responseText? _textReponse = responseText.start;
  responseSchedule? _scheduleReponse = responseSchedule.start;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  //Updated
  final TextEditingController _textDescriptionController =
      TextEditingController();
  final TextEditingController _textNameController = TextEditingController();

  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();
  bool isCheckListEvent;
  bool viewExistingTask;

  var textController = TextEditingController();
  TextTask _newTask = TextTask();
  _SaveTaskState(
      {this.isCheckListEvent = false, this.viewExistingTask = false}) {
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "Task Created",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox(fontSize) {
    final taskObserver = Provider.of<TaskObserver>(context);

    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return CheckboxListTile(
      title: Text("Make this a daily activity",
          style: TextStyle(fontSize: fontSize)),
      checkColor: Colors.white,
      activeColor: Colors.blue,
      value: (taskObserver.newTaskIsCheckList),
      onChanged: (bool? value) {
        print("Checkbox onChanged $value");
        taskObserver.setNewTaskAIsCheckList(value!);
      },
    );
  }

  //ref: https://pub.dev/packages/date_time_picker
  Widget _selectDate() {
    String dateLabelText = 'What date to send the task';
    String timeLabelText = 'What time to send the task';

    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: dateLabelText,
      timeLabelText: timeLabelText,
      selectableDayPredicate: (date) {
        return true;
      },
      onChanged: (value) {
        print("_selectDate: Datetime $value");
        selectedDateTime = DateTime.parse(value);
      },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print("onSaved $val"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);
    final settingObserver = Provider.of<SettingObserver>(context);

    List<Step> getSteps() => [
          // Screen 1
          Step(
            state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 0,
            title: const Text(
              'Task Type',
              style: TextStyle(fontSize: 12),
            ),
            content:
                // Padding(
                // padding: const EdgeInsets.symmetric(vertical: 16.0),
                // child:
                Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Send A New Task | Reminder',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),
                const SizedBox(
                    height: 55.0, child: Text('\n Select Task Type')),
                Container(
                  constraints:
                      const BoxConstraints.tightFor(width: 400, height: 70),
                  child: OutlinedButton.icon(
                      onPressed: () {
                        //muted
                        setState(() {
                          selectedIcon = 'walking';
                          taskType = 'Activity';
                        });

                        if (_stepIndex < (getSteps().length - 1)) {
                          //VALIDATE
                          _stepIndex += 1;
                        }
                      },
                      icon: const Icon(
                        FontAwesomeIcons.walking,
                        size: 40,
                        color: Colors.green,
                      ),
                      label: const Text(
                        '\t\t\t\t\t\t\t\t Send A task for the patient \n \t\t\t\t\t\t\t to review',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  constraints:
                      const BoxConstraints.tightFor(width: 400, height: 70),
                  child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedIcon = 'medkit';
                          taskType = 'Health Check';
                          selectedIconColor = 'red';
                        });
                        print('line 243 icon state:' + selectedIcon);

                        if (_stepIndex < (getSteps().length - 1)) {
                          //VALIDATE
                          _stepIndex += 2;
                        }
                      },
                      icon: const Icon(
                        //Updated
                        FontAwesomeIcons.briefcaseMedical,
                        size: 40,
                        color: Colors.red,
                      ),
                      label: const Text(
                        '\t\t\t\t\t\t\t\t Send A task for the patient \n \t\t\t\t\t\t\t to perform an action',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),

          // Screen 2
          Step(
            state: _stepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 1,
            title: const Text(
              'Details',
              style: TextStyle(fontSize: 12),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Send A New Task | Activity',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),
                const SizedBox(height: 15.0),

                Container(
                    child: const Align(
                  heightFactor: 1.5,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Name*',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),
                //______
                Container(
                  child: TextFormField(
                    // focusNode: textFocusNode,
                    controller: _textNameController,
                    onTap: () => textFocusNode.requestFocus(),
                    onChanged: (valueName) {
                      setState(() {
                        _textNameController.text = valueName;
                        enteredTaskName = valueName.toString();
                        _textNameController.selection =
                            TextSelection.fromPosition(
                                TextPosition(offset: valueName.length));
                      });
                    },
                    cursorColor: Colors.blue,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      labelText: 'Name ',
                      border: OutlineInputBorder(),
                      // errorText: 'Error message',
                      // suffixIcon: Icon(
                      //   Icons.error,
                      // ),
                    ),
                  ),
                ),

                const SizedBox(height: 10.0),

                Container(
                    child: const Align(
                  heightFactor: 1.5,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Description*',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),

                Container(
                  child: TextFormField(
                    // focusNode: textFocusNode,
                    onTap: () => textFocusNode.requestFocus(),
                    cursorColor: Colors.blue,
                    controller: _textDescriptionController,
                    keyboardType: TextInputType.multiline,
                    //updated
                    onChanged: (valueDescription) {
                      setState(() {
                        _textDescriptionController.text = valueDescription;
                        enteredTaskDescription = valueDescription.toString();
                        _textDescriptionController.selection =
                            TextSelection.fromPosition(
                                TextPosition(offset: valueDescription.length));
                      });
                    },
                    maxLines: 5,
                    maxLength: 150,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      labelText: 'Description',
                      border: OutlineInputBorder(),

                      // errorText: 'Error message',
                      // suffixIcon: Icon(
                      //   Icons.error,
                      // ),
                    ),
                  ),
                ),

                Container(
                    child: const Align(
                  heightFactor: 1.5,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Icon*',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),

                // ____First row of buttons
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 50,
                        child:
                            //__Button change on click to different color
                            ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.walking,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            unPressButtons();
                            _walkingFlag = !_walkingFlag;
                            selectedIcon = 'walking';
                          }),
                          style: ElevatedButton.styleFrom(
                              primary:
                                  _walkingFlag ? Colors.white : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        width: 90,
                        height: 50,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.utensils,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            unPressButtons();
                            _utensilFlag = !_utensilFlag;
                            selectedIcon = 'utensils';
                          }),
                          style: ElevatedButton.styleFrom(
                              primary:
                                  _utensilFlag ? Colors.white : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        width: 90,
                        height: 50,
                        //updated
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.capsules,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            unPressButtons();
                            _capsulesFlag = !_capsulesFlag;
                            selectedIcon = 'capsules';
                          }),
                          style: ElevatedButton.styleFrom(
                              primary: _capsulesFlag
                                  ? Colors.white
                                  : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),

                        padding: EdgeInsets.zero,
                      ),
                    ]),

                const SizedBox(height: 8.0),

                // Second row of buttons

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 90,
                        height: 50,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.tooth,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(
                            () {
                              unPressButtons();
                              _toothFlag = !_toothFlag;
                              selectedIcon = 'tooth';
                            },
                          ),
                          style: ElevatedButton.styleFrom(
                              primary:
                                  _toothFlag ? Colors.white : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        width: 90,
                        height: 50,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            unPressButtons();
                            _envelopeFlag = !_envelopeFlag;
                            selectedIcon = 'envelope';
                          }),
                          style: ElevatedButton.styleFrom(
                              primary: _envelopeFlag
                                  ? Colors.white
                                  : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      Container(
                        width: 90,
                        height: 50,
                        child: ElevatedButton(
                          child: const Icon(
                            FontAwesomeIcons.tshirt,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            unPressButtons();
                            _tshirtFlag = !_tshirtFlag;
                            selectedIcon = 'tshirt';
                          }),
                          style: ElevatedButton.styleFrom(
                              primary:
                                  _tshirtFlag ? Colors.white : Colors.blueGrey,
                              side: const BorderSide(
                                  color: Colors.blue, width: 2.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ]),

                const SizedBox(height: 10.0),

                Container(
                    child: const Align(
                  heightFactor: 1.5,
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Icon Color',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(46, 89, 132, 1),
                        fontWeight: FontWeight.bold),
                  ),
                )),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue)),
                              ),
                              value: colorDropdownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 2,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  colorDropdownValue = newValue!;
                                  if (newValue == 'Grey') {
                                    selectedIconColor = 'blueGrey';
                                  } else if (newValue == 'Green') {
                                    selectedIconColor = 'green';
                                  } else if (newValue == 'Purple') {
                                    selectedIconColor = 'purple';
                                  } else if (newValue == 'Orange') {
                                    selectedIconColor = 'deepOrange';
                                  } else if (newValue == 'Pink') {
                                    selectedIconColor = 'pink';
                                  } else if (newValue == 'Red') {
                                    selectedIconColor = 'red';
                                  }
                                });
                              },
                              items: <String>[
                                'Select Icon Color',
                                'Grey',
                                'Green',
                                'Purple',
                                'Orange',
                                'Pink',
                                'Red'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )))
                  ],
                ),

                const SizedBox(height: 10),

                // Text Response Radio Buttons

                // Container(
                //     child: const Align(
                //   heightFactor: .5,
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Text Response Required*',
                //     style: TextStyle(
                //         fontSize: 15,
                //         color: Color.fromRGBO(46, 89, 132, 1),
                //         fontWeight: FontWeight.bold),
                //   ),
                // )),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       //Text Yes Radio button
                //       Container(
                //           child: SizedBox(
                //         width: 150,
                //         child: RadioListTile<responseText>(
                //           title: const Text(
                //             'Yes',
                //             textAlign: TextAlign.start,
                //           ),
                //           toggleable: true,
                //           contentPadding:
                //               const EdgeInsets.symmetric(horizontal: .5),
                //           value: responseText.Yes,
                //           groupValue: _textReponse,
                //           onChanged: (responseText? value) {
                //             //This will hid keyboard when selected
                //             FocusScope.of(context).unfocus();
                //
                //             setState(() {
                //               _textReponse = value;
                //               selectedIsResponseRequired = true;
                //               // value.toString()=='Yes'?true:false;
                //             });
                //           },
                //         ),
                //       )),
                //
                //       //Text No Radio button
                //       Container(
                //           child: SizedBox(
                //         width: 150,
                //         child: RadioListTile<responseText>(
                //           title: const Text(
                //             'No',
                //             textAlign: TextAlign.left,
                //           ),
                //           toggleable: true,
                //           contentPadding:
                //               const EdgeInsets.symmetric(horizontal: .5),
                //           value: responseText.No,
                //           groupValue: _textReponse,
                //           onChanged: (responseText? value) {
                //             setState(() {
                //               _textReponse = value;
                //               selectedIsResponseRequired = false;
                //             });
                //           },
                //         ),
                //       )),
                //     ]),
              ],
            ),
          ),

          //Screen 3
          Step(
            state: StepState.complete,
            isActive: _stepIndex >= 2,
            title: const Text(
              'Schedule',
              style: TextStyle(fontSize: 12),
            ),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Send A New Task | Schedule',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(46, 89, 132, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                      child: const Align(
                    heightFactor: .5,
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Schedule*',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(46, 89, 132, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  )),

                  // Schedule Ratio Buttons: Screen 3
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //Schedule Now Radio button
                        Container(
                            child: SizedBox(
                          width: 150,
                          child: RadioListTile<responseSchedule>(
                            title: const Text(
                              'Now',
                              textAlign: TextAlign.start,
                            ),
                            toggleable: true,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: .5),
                            value: responseSchedule.Now,
                            groupValue: _scheduleReponse,
                            onChanged: (responseSchedule? value) {
                              //This will hide keyboard when selected
                              FocusScope.of(context).unfocus();

                              setState(() {
                                print('xxxxxxxxxxxxxxxxxxx$value');
                                _scheduleReponse = value;
                                selectedDate = DateTime.now().day.toString();
                              });
                            },
                          ),
                        )),

                        //Schedule Future Radio button
                        Container(
                            child: SizedBox(
                          width: 150,
                          child: RadioListTile<responseSchedule>(
                            title: const Text(
                              'Future',
                              textAlign: TextAlign.left,
                            ),
                            toggleable: true,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: .5),
                            value: responseSchedule.Future,
                            groupValue: _scheduleReponse,
                            onChanged: (responseSchedule? value) {
                              setState(() {
                                _scheduleReponse = value;
                                print(_scheduleReponse);
                              });
                            },
                          ),
                        )),
                      ]),

                  Visibility(
                    visible: _scheduleReponse == responseSchedule.Future,
                    child: Container(
                        child: const Align(
                      heightFactor: 1.5,
                      alignment: Alignment.topLeft,
                      child: Text(
                        'When to send task*',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(46, 89, 132, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),

                  Visibility(
                    visible: _scheduleReponse == responseSchedule.Future,
                    child: Container(child: _selectDate()
                        //DATE CALENDAR

                        ),
                  ),
                ]),
          ),

          // This is in case we want to add a complete step at the end of the process
          // Step(
          //   state: StepState.complete,
          //   isActive: _stepIndex >= 3,
          //   title: const Text('Confirm',style: TextStyle(fontSize: 11),),
          //   content: const Text('Confirm Task',
          //     textAlign: TextAlign.left,
          //     style: TextStyle(fontSize: 20, color: Color.fromRGBO(46, 89, 132, 1),
          //         fontWeight: FontWeight.bold),),
          // ),
        ];

    void onStepContinue() {
      if (_stepIndex < (getSteps().length - 1)) {
        //VALIDATE
        _stepIndex += 1;
      } else {
        // This will place the steps in a continous loop esle to provide confirmations
        // setState(() {
        // _stepIndex = 0;
        // });
      }
    }

    String taskId = "";
    //VIEW_Task MODE: Populated the details of the targeted Tasks into the UI
    if (taskObserver.currTaskForDetails != null) {
      taskId = taskObserver.currTaskForDetails!.taskId;

      textController = TextEditingController(
          text: taskObserver.currTaskForDetails!.localText);
    }

    var padding = MediaQuery.of(context).size.width * 0.02;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    var fontSize =
        fontSizeToPixelMap(settingObserver.userSettings.noteFontSize, false);

    const ICON_SIZE = 80.00;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: saveTaskScaffoldKey,
      body: Stepper(
        type: StepperType.horizontal,
        controlsBuilder: controlsBuilder,
        currentStep: _stepIndex,
        steps: getSteps(),
        onStepTapped: onStepTapped,
        onStepCancel: onStepCancel,
        onStepContinue: () {
          if (_stepIndex < (getSteps().length - 1)) {
            setState(() {
              _stepIndex += 1;
            });
          }
        },
      ),

      //     Observer(
      //   builder: (context) => SingleChildScrollView(
      //       padding: EdgeInsets.all(padding),
      //       child: Column(
      //         children: [
      //           TextField(
      //             controller: textController,
      //             maxLines: 5,
      //             style: TextStyle(fontSize: fontSize),
      //             decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 hintText: I18n.of(context)!.enterNoteText),
      //           ),
      //           DropdownButton<String>(
      //             value: _newTask.taskType,
      //             elevation: 16,
      //             style: const TextStyle(color: Colors.deepPurple),
      //             underline: Container(
      //               height: 2,
      //               color: Colors.deepPurpleAccent,
      //             ),
      //             onChanged: (String? newValue) {
      //               setState(() {
      //                 _newTask.taskType = newValue!;
      //                 if (_newTask.taskType == 'Health Check') {
      //                   _newTask.icon = 'medkit';
      //                   _newTask.iconColor = 'red';
      //                 }
      //               });
      //             },
      //             items: <String>['Activity', 'Health Check', 'defaultType']
      //                 .map<DropdownMenuItem<String>>((String value) {
      //               return DropdownMenuItem<String>(
      //                 value: value,
      //                 child: Text(value),
      //               );
      //             }).toList(),
      //           ),
      //           _selectDate(taskObserver.newTaskIsCheckList, I18n.of(context),
      //               settingObserver.userSettings.locale),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               //Cancel Btn
      //               GestureDetector(
      //                   onTap: () {
      //                     taskObserver.changeScreen(TASK_SCREENS.TASK);
      //                     taskObserver.setCurrTaskIdForDetails(null);
      //                   },
      //                   child: Column(
      //                     children: [
      //                       Transform.rotate(
      //                           angle: 180 * math.pi / 180,
      //                           child: Icon(
      //                             Icons.exit_to_app_rounded,
      //                             size: ICON_SIZE,
      //                             color: Colors.amber,
      //                           )),
      //                       Text(
      //                         I18n.of(context)!.cancel,
      //                         style: Theme.of(context).textTheme.bodyText1,
      //                       ),
      //                     ],
      //                   )),
      //               //Save Btn
      //               GestureDetector(
      //                   onTap: () {
      //                     _onSave(taskObserver);
      //                   },
      //                   child: Column(
      //                     children: [
      //                       Icon(
      //                         Icons.save,
      //                         size: ICON_SIZE,
      //                         color: Colors.green,
      //                       ),
      //                       Text(
      //                         I18n.of(context)!.saveNote,
      //                         style: Theme.of(context).textTheme.bodyText1,
      //                       ),
      //                     ],
      //                   )),
      //               //Delete Btn
      //               if (taskObserver.currTaskForDetails != null)
      //                 GestureDetector(
      //                     onTap: () {
      //                       //popup confirmation view
      //                       taskObserver
      //                           .deleteTask(taskObserver.currTaskForDetails);
      //                       taskObserver.changeScreen(TASK_SCREENS.TASK);
      //                     },
      //                     child: Column(
      //                       children: [
      //                         Icon(
      //                           Icons.delete_forever,
      //                           size: ICON_SIZE,
      //                           color: Colors.red,
      //                         ),
      //                         Text(
      //                           I18n.of(context)!.deleteNote,
      //                           style: Theme.of(context).textTheme.bodyText1,
      //                         ),
      //                       ],
      //                     ))
      //             ],
      //           )
      //         ],
      //       )),
      //   //bottomNavigationBar: BottomBar(3),
      // ),
    );
  }

  _onSave(TaskObserver taskObserver) {
    // if (textController.text.length > 0) {
    print(
        "taskObserver.currTaskForDetails: ${taskObserver.currTaskForDetails}");
    this._newTask.taskId = (taskObserver.currTaskForDetails != null)
        ? taskObserver.currTaskForDetails!.taskId
        : TextTask().taskId;
    this._newTask.name = textController.text;
    this._newTask.localText = textController.text;
    this._newTask.eventTime = taskObserver.newTaskEventTime;
    this._newTask.eventDate = taskObserver.newTaskEventDate;
    this._newTask.isCheckList = taskObserver.newTaskIsCheckList;
    if (taskObserver.newTaskIsCheckList == true) {
      this._newTask.recurrentType = "daily";
    }
    //__Objectspassed
    //updated
    this._newTask.name = _textNameController.text;
    this._newTask.description = _textDescriptionController.text;
    this._newTask.icon = selectedIcon;
    this._newTask.eventDate = _dateController.text;
    this._newTask.eventTime = _timeController.text;
    this._newTask.iconColor = selectedIconColor;
    this._newTask.sendTaskDateTime = selectedDateTime;

    //Screen one
    this._newTask.taskType = taskType;
    //Boolean radio button
    // this._newTask.isResponseRequired = selectedIsResponseRequired;

    print('---line 962 icon' + selectedIcon);
    taskObserver.deleteTask(taskObserver.currTaskForDetails);
    taskObserver.addTask(_newTask);
    _showToast();
    taskObserver.changeScreen(TASK_SCREENS.TASK);
    // }
    print('kkkkkkkkkkkkkkkk: line 962');
  }

  /// Show a dialog message confirming task was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(I18n.of(context)!.ok),
      onPressed: () {
        //navScreenObs.changeScreen(SCREEN_NAMES.TASK);
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text(I18n.of(context)!.noteSavedSuccess),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
    final taskObserver = Provider.of<TaskObserver>(context);

    return Padding(
      // This is the padding around the continue, cancel, and back buttons
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (_stepIndex == 1)
            (OutlinedButton(
                onPressed: controlsDetails.onStepContinue,
                child: const Text('Continue'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.blue, width: 2.0),
                    minimumSize: const Size(400, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)))))
          else if (_stepIndex == 2)
            (OutlinedButton(
                onPressed: () {
                  _stepIndex = 0;
                  _onSave(taskObserver);
                  print('================line 978');
                },
                child: const Text('Send Task'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.blue, width: 2.0),
                    minimumSize: const Size(400, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))))),

          // This function needs to return the home screen of tasks on the admin profile
          OutlinedButton(
              onPressed: () {
                taskObserver.changeScreen(TASK_SCREENS.TASK);
                controlsDetails.onStepCancel;
                _stepIndex = 0;
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                  side: const BorderSide(color: Colors.red, width: 2.0),
                  minimumSize: const Size(400, 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)))),

          //Updated so the back button does not show in the Health check schedule screen
          if (taskType == 'Activity' && _stepIndex > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  //_________
                  return onStepCancel();
                });
              },
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.blueAccent),
              ),
            )
        ],
      ),
    );
  }

  // __Update to not go back in the stepper
  void onStepTapped(step) {
    if (step > _stepIndex) {
      setState(() {
        _stepIndex = step;
      });
    }
  }

  void onStepCancel() {
    if (_stepIndex > 0) {
      setState(() {
        _stepIndex -= 1;
      });
    }
  }

  // void onStepContinue() {
  //   if (_stepIndex < (getSteps().length - 1)) {
  //     //VALIDATE
  //     _stepIndex += 1;
  //   }
  //   // else {
  //   //   // This will place the steps in a continous loop esle to provide confirmations
  //   //   // setState(() {
  //   //   // _stepIndex = 0;
  //   //   // });
  //   // }
  // }

}

//enum for Text Response, Schedule
enum responseText { start, Yes, No }
enum responseSchedule { start, Now, Future }
