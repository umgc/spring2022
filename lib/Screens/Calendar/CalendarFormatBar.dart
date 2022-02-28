import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/CalenderObservable.dart';

class calendarFormatBar extends StatefulWidget {
  const calendarFormatBar({Key? key}) : super(key: key);

  @override
  _calendarFormatBarState createState() => _calendarFormatBarState();
}

class _calendarFormatBarState extends State<calendarFormatBar> {
  @override
  Widget build(BuildContext context) {
    final calendarObserver = Provider.of<CalendarObservable>(context);


    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Week Button
        TextButton(
          style: TextButton.styleFrom(
            primary:
            calendarObserver.getWeekHasBeenPressed() ? Colors.black : Colors.blueGrey,
            textStyle: TextStyle(
              fontWeight: calendarObserver.getWeekHasBeenPressed()
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
              calendarObserver.weekView();
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
            calendarObserver.getMonthHasBeenPressed() ? Colors.black : Colors.blueGrey,
            textStyle: TextStyle(
              fontWeight: calendarObserver.getMonthHasBeenPressed()
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
              calendarObserver.monthView();
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
            calendarObserver.getDayHasBeenPressed() ? Colors.black : Colors.blueGrey,
            textStyle: TextStyle(
              fontWeight: calendarObserver.getDayHasBeenPressed()
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
            //calendarObserver.generateDailyTiles(),
            setState(() {
              calendarObserver.dayView();
            }),
          },
        ),
      ],

    );
  }
}
