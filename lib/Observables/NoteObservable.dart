import 'dart:collection';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';
import 'package:share_plus/share_plus.dart';

part 'NoteObservable.g.dart';

class NoteObserver = _AbstractNoteObserver with _$NoteObserver;

abstract class _AbstractNoteObserver with Store {
  _AbstractNoteObserver() {
    TextNoteService.loadNotes()
        .then((notes) => {setNotes(notes), setCheckList(notes)});
  }
  @observable
  File? _image;

  @observable
  ImagePicker imagePicker = ImagePicker();

  @observable
  NOTE_SCREENS currentScreen = NOTE_SCREENS.NOTE;

  @observable
  TextNote? currNoteForDetails;

  @observable
  List<TextNote> usersNotes = [];

  @observable
  Set<TextNote> checkListNotes = LinkedHashSet<TextNote>();

  //used when creating new note
  @observable
  bool newNoteIsCheckList = false;

  @observable
  String newNoteEventDate = "";

  @observable
  String newNoteEventTime = "";

  @action
  Future getImage() async{
    final image = await imagePicker.getImage(source: ImageSource.camera);
    _image =File(image!.path);
    Share.shareFiles([image.path]);
  }

  @action
  void addNote(TextNote note) {
    print("Adding note to: ${note.noteId}");
    usersNotes.add(note);
    TextNoteService.persistNotes(usersNotes);
  }

  @action
  void deleteNote(TextNote? note) {
    if (note == null) {
      print("deleteNote: param is null");
      return;
    }
    //remove from state
    usersNotes.remove(note);
    checkListNotes.remove(note);
    //remove from storage by over-writing content
    TextNoteService.persistNotes(usersNotes);
  }

  @action
  Future<void> setCurrNoteIdForDetails(noteId) async {
    print("Find Noteid: $noteId");

    for (TextNote note in usersNotes) {
      if (note.noteId == noteId) {
        currNoteForDetails = note;
        newNoteEventDate = note.eventDate;
        newNoteEventTime = note.eventTime;
        newNoteIsCheckList = note.isCheckList;
      }
    }
  }

  @action
  resetCurrNoteIdForDetails() async {
    currNoteForDetails = null;
    setNewNoteAIsCheckList(false);
    setNewNoteEventDate("");
    setNewNoteEventTime("");
  }

  @action
  void setNotes(notes) {
    print("set note to: ${notes}");
    usersNotes = notes;
  }

  @action
  List<TextNote> onSearchNote(String searchQuery) {
    List<TextNote> filteredResult = usersNotes
        .where((element) =>
            element.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return filteredResult;
  }

  @action
  void setCheckList(listOfNotes) {
    for (TextNote item in listOfNotes) {
      if (item.isCheckList == true || item.recurrentType == "daily") {
        checkListNotes.add(item);
      }
    }
  }

  @action
  void clearCheckList() {
    checkListNotes.clear();
  }

  @action
  void changeScreen(NOTE_SCREENS name) {
    print("Note Screen changed to: $name");
    currentScreen = name;
  }

  /*
  * Actions for creating new notes
  */
  @action
  void setNewNoteAIsCheckList(bool value) {
    newNoteIsCheckList = value;
  }

  @action
  void setNewNoteEventDate(String value) {
    print("setNewNoteEventDate: setting new Note date $value");
    newNoteEventDate = value;
  }

  @action
  void setNewNoteEventTime(String value) {
    print("setNewNoteEventTime: setting new Note time $value");
    newNoteEventTime = value;
  }
}
