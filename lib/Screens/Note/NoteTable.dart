import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../../Observables/NoteObservable.dart';

/// View Notes page
class NoteTable extends StatelessWidget {
  final List<TextNote> usersNotes;
  final Function? onListItemClickCallBackFn;
  //Flutter will autto assign this param to usersNotes
  NoteTable(this.usersNotes, this.onListItemClickCallBackFn);

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

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 5;
    var noteWidth = MediaQuery.of(context).size.width * 0.35;
    print("My width is $noteWidth");

    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return SingleChildScrollView(
      child: DataTable(
          dataRowHeight: rowHeight,
          headingRowHeight: 60,
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
            usersNotes.length,
            (int index) => DataRow(
              cells: <DataCell>[
                DataCell(Text("${(index + 1)}")),
                DataCell(
                  Container(
                      padding: EdgeInsets.all(10),
                      width: noteWidth,
                      child: Text(
                        usersNotes[index].localText,
                        style: TEXT_STYLE,
                      )),
                  showEditIcon: true,
                  onTap: () => {
                    screenNav.changeScreen(MAIN_SCREENS.NOTE),
                    noteObserver
                        .setCurrNoteIdForDetails(usersNotes[index].noteId)
                        .then((value) => noteObserver
                            .changeScreen(NOTE_SCREENS.NOTE_DETAIL)),
                    if (onListItemClickCallBackFn != null)
                      {onListItemClickCallBackFn!.call()}
                  },
                ),
                DataCell(Text(timeago.format(usersNotes[index].recordedTime,
                    locale: settingObserver.userSettings.locale.languageCode))),
              ],
            ),
          )),
    );
  }
}
