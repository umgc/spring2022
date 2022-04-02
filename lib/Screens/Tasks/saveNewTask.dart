import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Model/Task.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Services/TaskService.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/Utility/FontUtil.dart';
import 'package:memorez/generated/i18n.dart';
import '../../Observables/TaskObservable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

final saveTaskScaffoldKey = GlobalKey<ScaffoldState>();
enum responseText { start, Yes, No } //enum for Text Response, Schedule
enum responseSchedule { start, Now, Future } //enum for Text Response, Schedule

/// Save Task page
class SaveNewTask extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingTask;

  SaveNewTask({this.isCheckListEvent = false, this.viewExistingTask = false}) {}

  @override
  State<SaveNewTask> createState() => _SaveNewTaskState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingTask: this.viewExistingTask);
}

/// ONSAVE
class _SaveNewTaskState extends State<SaveNewTask> {
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

  ///these flags indicate whether or not a button has been pressed
  bool _walkingFlag = true;
  bool _utensilFlag = true;
  bool _capsulesFlag = true;
  bool _toothFlag = true;
  bool _envelopeFlag = true;
  bool _tshirtFlag = true;

  ///Starting Index of page stepper
  static int _stepIndex = 0;

  ///Initial value for dropdown list
  String colorDropdownValue = 'Select Icon Color';

  ///This was done to get an unfilled button
  responseText? _textReponse = responseText.start;
  responseSchedule? _scheduleReponse = responseSchedule.start;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _textDescriptionController =
      TextEditingController();
  final TextEditingController _textNameController = TextEditingController();

  /// Text task service to use for I/O operations against local system
  final TextTaskService textTaskService = new TextTaskService();
  bool isCheckListEvent;
  bool viewExistingTask;
  var textController = TextEditingController();

  ///Create a blank new TextTask
  TextTask _newTask = TextTask();

  @override
  Widget build(BuildContext context) {
    final taskObserver = Provider.of<TaskObserver>(context, listen: false);

    List<Step> getSteps() => [
          // Screen 1
          Step(
            state: _stepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _stepIndex >= 0,
            title: const Text(
              'Task Type',
              style: TextStyle(fontSize: 12),
            ),
            content: Column(
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
                        enteredTaskName = valueName;
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
                  )
                ]),
          ),
        ];

    void onStepContinue() {
      if (_stepIndex < (getSteps().length - 1)) {
        //VALIDATE
        _stepIndex += 1;
      }
    }

    String taskId = "";
    //VIEW_Task MODE: Populated the details of the targeted Tasks into the UI
    if (taskObserver.currTaskForDetails != null) {
      taskId = taskObserver.currTaskForDetails!.taskId;

      textController = TextEditingController(
          text: taskObserver.currTaskForDetails!.localText);
    }

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
    );
  }

  // saveNewTask Support Methods-----------------------------------------------
  /// Resets all the icons to the unpressed state
  void unPressButtons() {
    _walkingFlag = true;
    _utensilFlag = true;
    _capsulesFlag = true;
    _toothFlag = true;
    _envelopeFlag = true;
    _tshirtFlag = true;
  }

  /// Show & hide keyboard
  FocusNode textFocusNode = FocusNode();

  ///Calls to the task observer to set the values of a new task
  _onSave(TaskObserver taskObserver, SettingObserver settingObserver) {
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
    print('line 726 ' +
        settingObserver.userSettings.enableTasksNotifications.toString());
    if (settingObserver.userSettings.enableTasksNotifications) {
      print('sending out a notification for this task');
      DateTime dateTime = selectedDateTime;
      var _body = this._newTask.name;
      notify(_body, dateTime, settingObserver);
    }

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

  /// This prevents going backwards in the stepper
  void onStepTapped(step) {
    if (step > _stepIndex) {
      setState(() {
        _stepIndex = step;
      });
    }
  }

  ///This resets the stepper counter
  void onStepCancel() {
    if (_stepIndex > 0) {
      setState(() {
        _stepIndex -= 1;
      });
    }
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

  ///controlsBuilder Manages the steps and UI that is shown in each page
  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
    final taskObserver = Provider.of<TaskObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
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
                  _onSave(taskObserver, settingObserver);
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
                setState(
                  () {
                    return onStepCancel();
                  },
                );
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

  ///Resets/saves task state variables
  _SaveNewTaskState(
      {this.isCheckListEvent = false, this.viewExistingTask = false});

  ///Empties text fields
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void textDispose() {
    textFocusNode.dispose();
    super.dispose();
  }

  ///Alert dialog for task completion
  void _showToast() {
    Fluttertoast.showToast(
        msg: "Task Created",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  // These are not implemented yet----------------------------------------------
  ///Checkbox for daily recurrence (not implemented yet)
  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox(fontSize) {
    final taskObserver = Provider.of<TaskObserver>(context);

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
        setState(() {
          print("_selectDate: Datetime $value");
          selectedDateTime = DateTime.parse(value);
        });
      },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print("onSaved $val"),
    );
  }

  void notify(
      var _body, DateTime dateTime, SettingObserver settingObserver) async {
    print('Notification Calendar' +
        NotificationCalendar.fromDate(
                date: dateTime.subtract(Duration(
                    minutes: int.parse(settingObserver
                        .userSettings.minutesBeforeTaskNotifications))))
            .toString());
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1, channelKey: 'key1', title: 'Reminder', body: _body),
      schedule: NotificationCalendar.fromDate(
          date: dateTime.subtract(Duration(
              minutes: int.parse(settingObserver
                  .userSettings.minutesBeforeTaskNotifications))),
          allowWhileIdle: true),
    );
  }
}
