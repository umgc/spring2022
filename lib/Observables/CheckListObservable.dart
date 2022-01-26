import 'package:mobx/mobx.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Services/NoteService.dart';
part 'CheckListObservable.g.dart';

class CheckListObserver = _AbstractCheckListObserver with _$CheckListObserver;

abstract class _AbstractCheckListObserver with Store {
  @observable
  List<String> checkedNoteIDs = [];

  @observable
  DateTime selectedDay = DateTime.now();

  String lastSetDate = "";

  @action
  void setSelectedDay(DateTime day) {
    selectedDay = day;
  }

  @action
  void getCheckedList(String date) {
    print("getCheckedList() checked items for the $date ");
    if (lastSetDate != date) {
      print("getCheckedList() Reading $date ");
      checkedNoteIDs.clear();
      lastSetDate = date;
      TextNoteService.getDailyCheckedNote(date).then((value) => {
            checkedNoteIDs.addAll(value.split(",")),
            print("TextNoteService: value $value")
          });
    }
  }

  @action
  void checkItem(TextNote note) {
    if (checkedNoteIDs.contains(note.noteId)) {
      checkedNoteIDs.remove(note.noteId);
    } else {
      checkedNoteIDs.add(note.noteId);
    }
    TextNoteService.persistDailyCheckedNotes(checkedNoteIDs.join(","));
  }
}
