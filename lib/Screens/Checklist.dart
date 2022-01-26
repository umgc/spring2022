import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled3/Observables/CheckListObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';

class Checklist extends StatefulWidget {
  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    final checkListObserver = Provider.of<CheckListObserver>(context);
    final noteObserver = Provider.of<NoteObserver>(context);
    final settingObserver = Provider.of<SettingObserver>(context);
    //noteObserver.clearCheckList();
    noteObserver.setCheckList(noteObserver.usersNotes);
    checkListObserver
        .getCheckedList(checkListObserver.selectedDay.toString().split(" ")[0]);

    return Observer(
        builder: (_) => Column(children: <Widget>[
              TableCalendar(
                focusedDay: DateTime.now(),
                locale: settingObserver.userSettings.locale.languageCode,
                firstDay: DateTime.parse(
                    "2012-02-27"), //Date of the oldest past event
                lastDay: DateTime.now(), //Date of the last event
                selectedDayPredicate: (day) {
                  return isSameDay(checkListObserver.selectedDay, day);
                },

                calendarFormat: CalendarFormat.week,

                onDaySelected: (selectedDay, focusDay) {
                  print("Changed selected date $selectedDay");
                  checkListObserver.setSelectedDay(selectedDay);
                  String date = selectedDay.toString().split(" ")[0];
                  checkListObserver.getCheckedList(date);
                  (context as Element).reassemble();
                },

                onPageChanged: (focusedDay) {
                  print("onPageChanged: Day selected $focusedDay");
                },
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
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView(
                  children: noteObserver.checkListNotes.map((key) {
                    return Container(
                        padding: const EdgeInsets.all(20.0),
                        //constraints: BoxConstraints(),
                        child: CheckboxListTile(
                          title: Text("${key.localText}"),
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                          value: (checkListObserver.checkedNoteIDs
                              .contains(key.noteId)),
                          onChanged: (bool? value) {
                            print(
                                "Onchange: checkListObserver.selectedDay ${checkListObserver.selectedDay}");
                            if (checkListObserver.selectedDay
                                    .toString()
                                    .split(" ")[0] !=
                                DateTime.now().toString().split(" ")[0]) {
                              return;
                            }
                            print("Checkbox onChanged $value");
                            checkListObserver.checkItem(key);
                            (context as Element).reassemble();
                          },
                        ));
                  }).toList(),
                ),
              ),
            ]));
  }
}
