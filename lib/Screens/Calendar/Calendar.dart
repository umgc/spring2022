import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:memorez/Utility/ThemeUtil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:memorez/Model/CalendarEvent.dart';
import 'package:memorez/Model/Note.dart';
import 'package:memorez/Observables/CalenderObservable.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Observables/NoteObservable.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Screens/Calendar/CalendarFormatBar.dart';

final viewCalendarScaffoldKey = GlobalKey<ScaffoldState>();

//Variable Definitions ----------------------------------------
bool _filteredNotesIsVisible = false;

Color? textCol;

DateTime _focusedDay = DateTime.now();
List<CalenderEvent> _events = [];
ValueNotifier<bool> _dayAndEventsUpdated = ValueNotifier(false);

//--------------------------------------------------------------------------------

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  get calendarObserver => this.calendarObserver;
  List<TextNote> _matchedEvents = [];

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    final calendarObserver = Provider.of<CalendarObservable>(context);
    final settingObserver = Provider.of<SettingObserver>(context);

    textCol = textMode(settingObserver.userSettings.darkMode);

    calendarObserver.setNoteObserver(noteObserver);
    calendarObserver.generateDailyTiles();
    List<Container> _daysAndEvents = calendarObserver.generateDailyTiles();

    // This function is called whenever the text field changes
    void _runFilter(String value) {
      final List<TextNote> _allEvents = noteObserver.usersNotes;
      List<TextNote> _results = [];
      if ((value.isEmpty)) {
        setState(() {
          calendarObserver.changeFormat(CalendarFormat.month);
          calendarObserver.setCalendarBarIsVisible(true);

          calendarObserver.setMonthHasBeenPressed(true);
          calendarObserver.setWeekHasBeenPressed(false);
          calendarObserver.setDayHasBeenPressed(false);
          calendarObserver.setNotesOnDayIsVisible(false);

          calendarObserver.setCalendarIsVisible(true);

          _filteredNotesIsVisible = false;
        });
      } else {
        _results = _allEvents
            .where((event) =>
                event.text.toLowerCase().contains(value.toLowerCase()) &&
                event.eventDate.isEmpty == false)
            .toList();
        // Refresh the UI
        setState(() {
          _matchedEvents = _results;
          _filteredNotesIsVisible = true;
          calendarObserver.setCalendarBarIsVisible(false);
          calendarObserver.setCalendarIsVisible(false);
          calendarObserver.setDailyCalendarIsVisible(false);
          calendarObserver.setNotesOnDayIsVisible(false);
        });
      }
    }

    //This function builds the events on day list
    List<CalenderEvent> checkDays(DateTime day) {
      return calendarObserver
          .loadEventsOfSelectedDay(day.toString().split(" ")[0]);
    }

    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '--Search For A Note--',
              )),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: _filteredNotesIsVisible,
            child: Expanded(
              child: _matchedEvents.isNotEmpty
                  ? new ListView.builder(
                      itemCount: _matchedEvents.length,
                      itemBuilder: (context, index) => new Container(
                        key: ValueKey(_matchedEvents[index].noteId),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade50,
                          border: Border.all(color: Colors.blueGrey, width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: new ListTile(
                          //onTap: () => print('${value[index]}'),
                          title: Text("${_matchedEvents[index].text}",
                              style: TextStyle(color: textCol),
                              textAlign: TextAlign.center),
                          subtitle: Text(
                              "${DateFormat('MM-dd-yyyy').format(DateTime.parse((_matchedEvents[index].eventDate)))} \t at \t ${_matchedEvents[index].eventTime}",
                              style: TextStyle(color: textCol),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ),

          //Calendar Buttons "Week | Month | Day"-------------------------------
          Visibility(
            visible: calendarObserver.getCalendarBarIsVisible(),
            child: calendarFormatBar(),
          ),

          //Calendar Table------------------------------------------------------
          Visibility(
            visible: calendarObserver.getCalendarIsVisible(),
            child: TableCalendar(
              //this sets the calendar Format to what is found in the observer
              calendarFormat: calendarObserver.calendarFormat,
              //This reaches into the TableCalendar and sets some header properties
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                headerPadding: EdgeInsets.all(5),
              ),
              rowHeight: MediaQuery.of(context).size.height/15.2,
              focusedDay: _focusedDay,
              locale: settingObserver.userSettings.locale.languageCode,
              firstDay: calendarObserver
                  .getStartDay(), //Date of the oldest past event
              lastDay: calendarObserver.getEndDay(), //Date of the last event
              selectedDayPredicate: (day) {
                return isSameDay(calendarObserver.selectedDay, day);
              },
              //-------------------------------------------------------------------------------------------
              //This event loader is causing an error and slowing this whole thing down
              eventLoader: (DateTime day) {
                return checkDays(day);
              },
              //-----------------------------------------------------------------------------------------
              onDaySelected: (selectedDay, focusDay) {
                _focusedDay = selectedDay;
                print("onDaySelected selectedDay: $selectedDay");
                //extract the date portion
                calendarObserver.setSelectedDay(selectedDay);
                _events = calendarObserver.loadEventsOfSelectedDay(
                    selectedDay.toString().split(" ")[0]);

                if (_events.length > 0) {
                  calendarObserver.weekView();
                  try {
                    calendarObserver.getNotesOnDay();
                  }catch (error) {
                    print('setttttttttttttttt state errrrrrrrrrrrrrrror');
                  }
                }
                (context as Element).reassemble();
              },

              onPageChanged: (focusedDay) {},
              calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
            ),
          ),

          const SizedBox(height: 8.0),

          //Scrolling Daily View of the Calendar--------------------------------
          Visibility(
            visible: calendarObserver.getDailyCalendarIsVisible(),
            child: Expanded(
              child: ValueListenableBuilder<bool>(
                  valueListenable: _dayAndEventsUpdated,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: _daysAndEvents.length,
                      itemExtent: 50,
                      controller: ScrollController(
                          initialScrollOffset:
                              50 * _daysAndEvents.length / 2 - 50),
                      itemBuilder: (context, index) => new Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          key: ValueKey(_daysAndEvents[index]),
                          child: _daysAndEvents[index]),
                    );
                  }),
            ),
          ),

          const SizedBox(height: 8.0),
          Visibility(
            visible: calendarObserver.getNotesOnDayIsVisible(),
            child: Expanded(
              child: ListView.builder(
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        border: Border.all(color: Colors.blueGrey, width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        //onTap: () => print('${value[index]}'),
                        title: Text(
                            "${_events[index]} \t at \t ${_events[index].time}",
                            textAlign: TextAlign.center),
                      ),
                    );
                  }),
            ),
          )
          //Area under Calendar displaying notes--------------------------------
          // Visibility(
          //   visible: calendarObserver.getNotesOnDayIsVisible(),
          //   child: Expanded(
          //       child: ValueListenableBuilder<List<CalenderEvent>>(
          //     valueListenable: calendarObserver.selectedEvents,
          //     builder: (context, value, _) {
          //       print("Initialized Value Notifier: ");
          //       return ListView.builder(
          //           itemCount: value.length,
          //           itemBuilder: (context, index) {
          //             return Container(
          //               height: 50,
          //               margin: const EdgeInsets.symmetric(
          //                 horizontal: 12.0,
          //                 vertical: 3,
          //               ),
          //               decoration: BoxDecoration(
          //                 color: Colors.lightBlue.shade50,
          //                 border: Border.all(color: Colors.blueGrey, width: 1),
          //                 borderRadius: BorderRadius.circular(12.0),
          //               ),
          //               child: ListTile(
          //                 //onTap: () => print('${value[index]}'),
          //                 title: Text(
          //                     "${value[index]} \t at \t ${value[index].time}",
          //                     textAlign: TextAlign.center),
          //               ),
          //             );
          //           });
          //     },
          //   )),
          // )
        ]),
      ),
    );
  }
}
