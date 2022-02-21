import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/CalendarEvent.dart';
import 'package:untitled3/Observables/CalenderObservable.dart';

class NotesOnDay extends StatefulWidget {
  NotesOnDay();

  @override
  _NotesOnDayState createState() => _NotesOnDayState();
}

class _NotesOnDayState extends State<NotesOnDay> {
  @override
  Widget build(BuildContext context) {
    final calendarObserver = Provider.of<CalendarObservable>(context);

    return ValueListenableBuilder<List<CalenderEvent>>(
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
                  //onTap: () => print('${value[index]}'),
                  title: Text("${value[index]} \t at \t ${value[index].time}",
                      textAlign: TextAlign.center),
                ),
              );
            });
      },
    );
  }
}