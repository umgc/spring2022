import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Model/CalendarEvent.dart';
import 'package:untitled3/Observables/CalenderObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/CalendarUtility.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/generated/i18n.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  // @override
  // void dispose() {
  //   //_selectedEvents.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    final calendarObserver = Provider.of<CalendarObservable>(context);
    final settingObserver = Provider.of<SettingObserver>(context);

    calendarObserver.setNoteObserver(noteObserver);
    return Observer(
        builder: (_) => Column(children: [
              TableCalendar(
                focusedDay: DateTime.now(),
                locale: settingObserver.userSettings.locale.languageCode,
                firstDay: DateTime.parse(
                    "2012-02-27"), //Date of the oldest past event
                lastDay: DateTime.parse("2022-02-27"), //Date of the last event
                selectedDayPredicate: (day) {
                  return isSameDay(calendarObserver.selectedDay, day);
                },

                calendarFormat: calendarObserver.calendarFormat,
                eventLoader: (DateTime day) {
                  return calendarObserver
                      .loadEventsOfSelectedDay(day.toString().split(" ")[0]);
                },
                onFormatChanged: (format) {
                  calendarObserver.changeFormat(format);
                },
                onDaySelected: (selectedDay, focusDay) {
                  print("onDaySelected selectedDay: $selectedDay");
                  //exctract the date portion
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
              ElevatedButton(
                child: Text(I18n.of(context)!.clearSelection),
                onPressed: () {},
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<CalenderEvent>>(
                    valueListenable: calendarObserver.selectedEvents,
                    builder: (context, value, _) {
                      print("Initialized Value Notifier: ");
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () => print('${value[index]}'),
                              title: Text(
                                  '${value[index]} \t at \t ${value[index].time}',
                                  textAlign: TextAlign.center),
                            ),
                          );
                        },
                      );
                    }),
              )
            ]));
  }
}
