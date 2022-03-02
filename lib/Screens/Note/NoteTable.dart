import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../../Observables/NoteObservable.dart';
import 'package:untitled3/Services/NoteService.dart';

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
    // String noteDetailScreen =I18n.of(context)!.notesDetailScreenName;
    // String addNoteScreen =I18n.of(context)!.addNotesScreenName;
    // String noteScreen =I18n.of(context)!.notesScreenName;
    final screenNav = Provider.of<MainNavObserver>(context);

    final noteObserver = Provider.of<NoteObserver>(context);
    noteObserver.resetCurrNoteIdForDetails();

    final settingObserver = Provider.of<SettingObserver>(context);

    const TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 7;
    var noteWidth = MediaQuery.of(context).size.width * 0.35;
    print("My width is $noteWidth");
    // This function is called whenever the text field changes
    List<TextNote> filteredUsersNotes = [];

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

    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '--Search For A Note--',
            ),
            onChanged: (value) {
              _runFilter(value);
            },
          ),
          Visibility(
            visible: _unfilteredNotes,
            child: DataTable(
                dataRowHeight: rowHeight,
                headingRowHeight: 60,
                columnSpacing: 30,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      '',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOTE',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CREATED',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.usersNotes.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text("${(index + 1)}")),
                      DataCell(
                        Container(
                            padding: EdgeInsets.all(10),
                            width: noteWidth,
                            child: Text(
                              widget.usersNotes[index].localText,
                              style: TEXT_STYLE,
                            )),
                        showEditIcon: true,
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
                      DataCell(Text(timeago.format(
                          widget.usersNotes[index].recordedTime,
                          locale: settingObserver
                              .userSettings.locale.languageCode))),
                    ],
                  ),
                )),
          ),
          Visibility(
            visible: _filteredNotesIsVisible,
            child: DataTable(
                dataRowHeight: rowHeight,
                headingRowHeight: 60,
                columnSpacing: 30,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      '',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOTE',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CREATED',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  widget.usersNotes.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text("${(index + 1)}")),
                      DataCell(
                        Container(
                            padding: EdgeInsets.all(10),
                            width: noteWidth,
                            child: Text(
                              widget.usersNotes[index].localText,
                              style: TEXT_STYLE,
                            )),
                        showEditIcon: true,
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
                      DataCell(Text(timeago.format(
                          widget.usersNotes[index].recordedTime,
                          locale: settingObserver
                              .userSettings.locale.languageCode))),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
