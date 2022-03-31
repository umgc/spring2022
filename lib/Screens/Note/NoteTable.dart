import 'package:flutter/material.dart';
import 'package:memorez/generated/i18n.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:memorez/Model/Note.dart';
import 'package:memorez/Observables/ScreenNavigator.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Utility/Constant.dart';
import '../../Observables/NoteObservable.dart';
import 'package:memorez/Services/NoteService.dart';
import 'package:intl/intl.dart';

bool _filteredNotesIsVisible = false;
bool _unfilteredNotes = true;

/// View Notes page
class NoteTable extends StatefulWidget {
  final List<TextNote> usersNotes;
  final Function? onListItemClickCallBackFn;

  //Flutter will auto assign this param to usersNotes
  NoteTable(this.usersNotes, this.onListItemClickCallBackFn);

  @override
  State<NoteTable> createState() => _NoteTableState();
}

class _NoteTableState extends State<NoteTable> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenNav = Provider.of<MainNavObserver>(context);

    final noteObserver = Provider.of<NoteObserver>(context);
    noteObserver.resetCurrNoteIdForDetails();
    TextEditingController().clear();
    TextNoteService.loadNotes().then((notes) =>
        {noteObserver.setNotes(notes), noteObserver.setCheckList(notes)});
    final settingObserver = Provider.of<SettingObserver>(context);

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 8;
    var noteWidth = MediaQuery.of(context).size.width * 0.87;
    print("My width is $noteWidth");

    List<TextNote> filteredUsersNotes = [];

    // This is called whenever the text field changes
    void _runFilter(String value) {
      if ((value.isEmpty || value == '')) {
        noteObserver.changeScreen(NOTE_SCREENS.NOTE);
        TextNoteService.loadNotes().then((notes) =>
            {noteObserver.setNotes(notes), noteObserver.setCheckList(notes)});

        setState(() {
          _filteredNotesIsVisible = false;
          _unfilteredNotes = true;
        });
      } else {
        // Refresh the UI
        noteObserver.changeScreen(NOTE_SCREENS.NOTE);

        filteredUsersNotes = noteObserver.usersNotes
            .where((element) =>
                element.text.toLowerCase().contains(value.toLowerCase()))
            .toList();

        noteObserver.usersNotes = filteredUsersNotes;
        setState(() {
          _filteredNotesIsVisible = true;
          _unfilteredNotes = false;
        });
      }
    }

    DateTime _getTime(int index) {
      String dateString = widget.usersNotes[index].eventTime;
      DateTime date = DateTime.now();
      try {
        date = DateTime.parse(dateString);
      } on Exception catch (_) {
        return date;
      }
      return date;
    }

    final RegExp regexp = new RegExp(r'^0+(?=.)');
    bool _checkboxToggle = false;

        return SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '-- ' + I18n.of(context)!.searchForNote + ' --',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                ),
                onChanged: (value) {
                  _runFilter(value);
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  primary: Colors.white,
                  fixedSize: Size(noteWidth, 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                icon: Icon(
                  Icons.add,
                ),
                label: Text(
                  I18n.of(context)!.addNote,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  noteObserver.changeScreen(NOTE_SCREENS.ADD_NOTE);
                },
              ),
              //THIS TABLE IS VISABLE WHEN THE SEARCH BAR IS EMPTY
              Visibility(
                visible: _unfilteredNotes,
                child: DataTable(
                  showCheckboxColumn: _checkboxToggle,
                  dataRowHeight: rowHeight,
                  headingRowHeight: 0,
                  columnSpacing: 30,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: SizedBox(
                        height: 0,
                      ),
                    ),
                    // DataColumn(
                    //   label: Text(
                    //     'NOTE',
                    //     style: HEADER_TEXT_STYLE,
                    //   ),
                    // ),
                    // DataColumn(
                    //   label: Text(
                    //     'CREATED',
                    //     style: HEADER_TEXT_STYLE,
                    //   ),
                    // ),
                  ],
                  rows: List<DataRow>.generate(
                    widget.usersNotes.length,
                    (int index) => DataRow(

                      //onSelectChanged: _selectNotes,
                      cells: <DataCell>[
                        // DataCell(Text("${(index + 1)}")),
                        DataCell(
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              width: noteWidth,
                              child: Text(
                                widget.usersNotes[index].localText +
                                    '\n(' +
                                    DateFormat.MMMEd().format(DateTime.parse(
                                        _getTime(index).toString())) +

                                // widget.usersNotes[index].eventDate)) +
                                ' at ' +
                                widget.usersNotes[index].eventTime
                                    .replaceAll(regexp, '') +
                                ')',
                            style: TEXT_STYLE,
                          )),
                      onTap: () => {
                        screenNav.changeScreen(MAIN_SCREENS.NOTE),
                        noteObserver
                            .setCurrNoteIdForDetails(
                                widget.usersNotes[index].noteId)
                            .then((value) => noteObserver
                                .changeScreen(NOTE_SCREENS.NOTE_DETAIL)),
                        if (widget.onListItemClickCallBackFn != null)
                          {widget.onListItemClickCallBackFn!.call()}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          //THIS TABLE IS VISIBLE WHEN SOMETHING IS TYPED INTO THE SEARCH BAR
          Visibility(
            visible: _filteredNotesIsVisible,
            child: DataTable(
              showCheckboxColumn: _checkboxToggle,
              dataRowHeight: rowHeight,
              headingRowHeight: 0,
              columnSpacing: 30,
              columns: const <DataColumn>[
                DataColumn(
                  label: SizedBox(
                    height: 0,
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                widget.usersNotes.length,
                (int index) => DataRow(
                  cells: <DataCell>[
                    // DataCell(Text("${(index + 1)}")),
                    DataCell(
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          width: noteWidth,
                          child: Text(
                            widget.usersNotes[index].localText +
                                '\n(' +
                                DateFormat.MMMEd().format(DateTime.parse(
                                    _getTime(index).toString())) +
                                ' at ' +
                                widget.usersNotes[index].eventTime
                                    .replaceAll(regexp, '') +
                                ')',
                            style: TEXT_STYLE,
                          )),
                      onTap: () => {
                        screenNav.changeScreen(MAIN_SCREENS.NOTE),
                        noteObserver
                            .setCurrNoteIdForDetails(
                                widget.usersNotes[index].noteId)
                            .then((value) => noteObserver
                                .changeScreen(NOTE_SCREENS.NOTE_DETAIL)),
                        if (widget.onListItemClickCallBackFn != null)
                          {widget.onListItemClickCallBackFn!.call()}
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
