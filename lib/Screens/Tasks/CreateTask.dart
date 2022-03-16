import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Send Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

//enum for Text Response, Schedule
enum responseText { start, Yes, No }
enum responseSchedule { start, Now, Future }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Date Vairiables
  // ValueNotifier<bool>selectDayChange =ValueNotifier(false);
  // String date = "";
  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  //App Bar Title
  static const String _title = 'Tasks';

  //Index of stepper
  static int _stepIndex = 0;
  //Initial value for dropdown list
  String colorDropdownValue = 'Select Icon Color';

  //This was done to get an unfilled button
  responseText? _textReponse = responseText.start;
  responseSchedule? _scheduleReponse = responseSchedule.start;

  // String getDateText(){
  //   if (date = null){
  //     return 'mm/dd/yyy'
  //   }else {
  //     return '${date.month}/${date.day}/${date.year}';
  //   }
  // }

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
              const SizedBox(height: 55.0, child: Text('\n Select Task Type')),
              Container(
                constraints:
                    const BoxConstraints.tightFor(width: 400, height: 70),
                child: OutlinedButton.icon(
                    onPressed: onStepContinue,
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
                    onPressed: onStepContinue,
                    icon: const Icon(
                      FontAwesomeIcons.clinicMedical,
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

              Container(
                child: TextFormField(
                  // initialValue: 'Name',
                  // onEditingComplete: ,
                  cursorColor: Colors.blue,
                  textInputAction: TextInputAction.continueAction,
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
                  // initialValue: 'Name',
                  // onEditingComplete: ,
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.multiline,
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

              // First row of buttons
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.walking,
                        color: Colors.black,
                      )),
                  padding: EdgeInsets.zero,
                ),

                // ElevatedButton.icon(onPressed: controlsDetails.onStepContinue,
                //     icon: const Icon(Icons.add_circle_outline,),
                //     label: const Text('New Task'),
                //     style: ElevatedButton.styleFrom(
                //         primary: Colors.blue,
                //         side: const BorderSide(color: Colors.blue, width: 2.0),
                //         minimumSize: const Size(400, 35),
                //         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(18.0)
                //         )
                //     )
                //
                // )

                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.utensils,
                        color: Colors.black,
                      )),
                  padding: EdgeInsets.zero,
                ),

                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.prescriptionBottle,
                        color: Colors.black,
                      )),
                  padding: EdgeInsets.zero,
                ),
              ]),

              const SizedBox(height: 8.0),

              // Second row of buttons

              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.tooth,
                        color: Colors.black,
                      )),
                  padding: EdgeInsets.zero,
                ),
                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.black,
                      )),
                  padding: EdgeInsets.zero,
                ),
                Container(
                  width: 90,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      child: const Icon(
                        FontAwesomeIcons.tshirt,
                        color: Colors.black,
                      )),
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
                          width: 325,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: Colors.blue)),
                            ),
                            value: colorDropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 2,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              setState(() {
                                colorDropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'Select Icon Color',
                              'Blue',
                              'Red',
                              'Green',
                              'Yellow',
                              'Purple',
                              'Grey',
                              'Black'
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

              // Text Radio Buttons

              Container(
                  child: const Align(
                heightFactor: .5,
                alignment: Alignment.topLeft,
                child: Text(
                  'Text Response Required*',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(46, 89, 132, 1),
                      fontWeight: FontWeight.bold),
                ),
              )),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Text Yes Radio button
                    Container(
                        child: SizedBox(
                      width: 150,
                      child: RadioListTile<responseText>(
                        title: const Text(
                          'Yes',
                          textAlign: TextAlign.start,
                        ),
                        toggleable: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: .5),
                        value: responseText.Yes,
                        groupValue: _textReponse,
                        onChanged: (responseText? value) {
                          //This will hid keyboard when selected
                          FocusScope.of(context).unfocus();

                          setState(() {
                            _textReponse = value;
                          });
                        },
                      ),
                    )),

                    //Text No Radio button
                    Container(
                        child: SizedBox(
                      width: 150,
                      child: RadioListTile<responseText>(
                        title: const Text(
                          'No',
                          textAlign: TextAlign.left,
                        ),
                        toggleable: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: .5),
                        value: responseText.No,
                        groupValue: _textReponse,
                        onChanged: (responseText? value) {
                          setState(() {
                            _textReponse = value;
                          });
                        },
                      ),
                    )),
                  ]),
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
                              _scheduleReponse = value;
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
                            });
                          },
                        ),
                      )),
                    ]),

                Container(
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
                Container(
                    child:
                        //DATE CALENDAR

                        TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(FontAwesomeIcons.calendarDay),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      confirmText: 'SET DATE',
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        _dateController.text =
                            '${selectedDate.month.toString()}/${selectedDate.day.toString()}/${selectedDate.year.toString()}';
                      }
                    });
                  },
                )),

                const SizedBox(height: 20),

                Container(
                  child: TextFormField(
                    readOnly: true,
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      suffixIcon: Icon(FontAwesomeIcons.solidClock),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      await showTimePicker(
                        context: context,
                        confirmText: 'SET TIME',
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                      ).then((selectedTime) {
                        if (selectedTime != null) {
                          _timeController.text =
                              '${selectedTime.hourOfPeriod.toString()}:${selectedTime.minute} ${selectedTime.period.name}';
                        }
                      });
                    },
                  ),
                )
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

  void onStepCancel() {
    if (_stepIndex > 0) {
      setState(() {
        _stepIndex -= 1;
      });
    }
  }

  void onStepTapped(int index) {
    setState(() {
      _stepIndex = index;
    });
  }

  // Future selectTime(BuildContext context) async{
  //   final TimeOfDay? timeOfDay = await showTimePicker(
  //     context: context,
  //     confirmText: 'SET TIME',
  //     initialTime: selectedTime,
  //
  //     initialEntryMode: TimePickerEntryMode.dial,
  //   );
  //   if(timeOfDay != null && timeOfDay != selectedTime)
  //   {
  //     setState(() {
  //       selectedTime = timeOfDay; });}}

  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
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
                onPressed: controlsDetails.onStepContinue,
                child: const Text('Send Task'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.blue, width: 2.0),
                    minimumSize: const Size(400, 35),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))))),

          // This function needs to return the home screen of tasks on the admin profile
          OutlinedButton(
              onPressed: controlsDetails.onStepCancel,
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

          if (_stepIndex != 0)
            TextButton(
              onPressed: controlsDetails.onStepCancel,
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.blueAccent),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: const Text(_title)),
      body: Stepper(
        type: StepperType.horizontal,
        controlsBuilder: controlsBuilder,
        currentStep: _stepIndex,
        steps: getSteps(),
        onStepTapped: onStepTapped,
        onStepCancel: onStepCancel,
        onStepContinue: onStepContinue,
      ),
    );
  }
}

// Working State
// void main() {
//
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//           appBar:  AppBar(
//               centerTitle: false,
//               title: const Text( 'Admin Mode 2', textAlign: TextAlign.left,)
//           ),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: const <Widget>[
//               Text('Send A New Task | Reminder', textAlign: TextAlign.left, style: TextStyle(fontSize: 20, color: Color.fromRGBO(46, 89, 132, 1),fontWeight: FontWeight.bold), ),
//
//               Text('\n Send  a task for the patient to perform an action', style: TextStyle(fontSize: 12), ),
//
//
//             ],
//           )
//
//       ),
//
//     ),
//   );
//
// }
