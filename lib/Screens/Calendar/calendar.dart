
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/CalenderObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Screens/Calendar/notesOnSelectedDay.dart';

final viewCalendarScaffoldKey = GlobalKey<ScaffoldState>();

//Current button and View State attributes /////////////////////////////////////
bool _weekHasBeenPressed = false;
bool _monthHasBeenPressed = true;
bool _dayHasBeenPressed = false;

bool _calendarIsVisable = true;
bool _dailyCalendarIsVisible = false;
bool _notesOnDayIsVisible = true;
bool _filteredNotesIsVisible = false;
bool _calendarBarIsVisible = true;

var _calendarFormat = CalendarFormat.month;
var _focusedDay = DateTime.now();
////////////////////////////////////////////////////////////////////////////////

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {

  List<TextNote> _matchedEvents = [];

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    final calendarObserver = Provider.of<CalendarObservable>(context);
    final settingObserver = Provider.of<SettingObserver>(context);

    calendarObserver.setNoteObserver(noteObserver);
    calendarObserver.calendarFormat = _calendarFormat;


    // This function is called whenever the text field changes
    void _runFilter(String value) {
      final List<TextNote> _allEvents = noteObserver.usersNotes;
      List<TextNote> _results = [];
      if((value.isEmpty) ) {

        setState(() {
          _filteredNotesIsVisible = false;
          _calendarIsVisable = true;
        });
      }else {
        _results = _allEvents.where((event) => event.text.toLowerCase().contains(value.toLowerCase())).toList();
        // Refresh the UI
        setState(() {
          _matchedEvents = _results;
          _filteredNotesIsVisible = true;
          _calendarIsVisable = false;
          _calendarBarIsVisible = false;
        });
      }
      }

    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
             TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '--Search For A Note--',
              )
            ),
            const SizedBox(
              height: 15,
            ),
            Visibility(
            visible: _filteredNotesIsVisible,
            child:
            Expanded(
              child: _matchedEvents.isNotEmpty
                  ? new ListView.builder(
                itemCount: _matchedEvents.length,
                itemBuilder: (context, index) =>
              new Container(
                key: ValueKey(_matchedEvents[index].noteId),
              margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
              ),
              decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
              ),
              child: new ListTile(
             //onTap: () => print('${value[index]}'),
             title: Text("${_matchedEvents[index].text} \t at \t ${_matchedEvents[index].eventTime}", textAlign: TextAlign.center),
              ),
            ),
           ): const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ),
            Visibility(
              visible: _calendarBarIsVisible,
              child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Week Button
                TextButton(
                  style: TextButton.styleFrom(
                    primary:
                        _weekHasBeenPressed ? Colors.black : Colors.blueGrey,
                    textStyle: TextStyle(
                      fontWeight: _weekHasBeenPressed
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Week',
                      ),
                    ],
                  ),
                  onPressed: () => {
                    setState(() {
                      _weekHasBeenPressed = true;
                      _dayHasBeenPressed = true;
                      _monthHasBeenPressed = true;
                      _dailyCalendarIsVisible = false;

                      _calendarIsVisable = true;
                      _notesOnDayIsVisible = true;
                      _calendarFormat = CalendarFormat.week;
                    })
                  },
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 1,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary:
                        _monthHasBeenPressed ? Colors.black : Colors.blueGrey,
                    textStyle: TextStyle(
                      fontWeight: _monthHasBeenPressed
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15.0),
                      Text(
                        'Month',
                      ),
                    ],
                  ),
                  onPressed: () => {
                    setState(() {
                      _monthHasBeenPressed = true;
                      _weekHasBeenPressed = false;
                          _dayHasBeenPressed = false;
                          _dailyCalendarIsVisible = false;

                      _calendarIsVisable = true;
                      _notesOnDayIsVisible = true;
                      _calendarFormat = CalendarFormat.month;
                    })
                  },
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 1,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary:
                        _dayHasBeenPressed ? Colors.black : Colors.blueGrey,
                    textStyle: TextStyle(
                      fontWeight: _dayHasBeenPressed
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15.0),
                      Text(
                        'Day',
                      ),
                    ],
                  ),
                  onPressed: () => {
                    setState(() {
                      _dayHasBeenPressed = true;
                      _dailyCalendarIsVisible = true;
                      _monthHasBeenPressed = false;
                      _weekHasBeenPressed = false;

                      _calendarIsVisable = false;
                      _notesOnDayIsVisible=false;
                    })
                  },
                ),
              ],
            ),
            ),
            Visibility(
              visible: _calendarIsVisable,
              child: TableCalendar(
                //this sets the clalendarFormat to what is found in the observer
                calendarFormat: calendarObserver.calendarFormat,
                //This reaches into the TableCalendar and sets some header properties
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: EdgeInsets.all(5),
                ),
                focusedDay: _focusedDay,
                locale: settingObserver.userSettings.locale.languageCode,
                firstDay: DateTime.parse(
                    "2022-02-15"), //Date of the oldest past event
                lastDay: DateTime.parse("2023-02-27"), //Date of the last event
                selectedDayPredicate: (day) {
                  return isSameDay(calendarObserver.selectedDay, day);
                },

                eventLoader: (DateTime day) {
                  return calendarObserver
                      .loadEventsOfSelectedDay(day.toString().split(" ")[0]);
                },
                onDaySelected: (selectedDay, focusDay) {
                  _focusedDay = selectedDay;
                  print("onDaySelected selectedDay: $selectedDay");
                  //extract the date portion
                  calendarObserver.setSelectedDay(selectedDay);
                  calendarObserver.loadEventsOfSelectedDay(
                      selectedDay.toString().split(" ")[0]);

                  (context as Element).reassemble();
                },

                onPageChanged: (focusedDay) {},
                calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    //selectedTextStyle: TextStyle(),
                    //todayDecoration: Colors.orange,
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    //OnDaySelected: Theme.of(context).primaryColor,
                    selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8.0),
            Visibility(
                visible: _dailyCalendarIsVisible,
                child: Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              color: Colors.lightBlue[100 * (index % 9)],
                              child: Text('List Item $index'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8.0),
            Visibility(
              visible: _notesOnDayIsVisible,
              child: Expanded(
                child:
                    NotesOnDay(), //This is the area below the calendar that shows the notes/reminders
              ),
            )
          ],
        ),
      ),
    );
  }
}
