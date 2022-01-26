import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Services/NoteService.dart';

class TextNote {
  TextNote();

  /// Name of the text note file
  String noteId = TextNoteService.generateUUID();

  /// Date and time when the text note was recorded
  DateTime recordedTime = DateTime.now();

  //language
  String language = "en";

  //true for check list Item
  bool isCheckList = false;

  //Event might occur daily, weekl, monthly or yearly
  //Default is 'none' for singly occurrence events
  String recurrentType = "none";

  //true for check list Item
  bool isEvent = false;

  /// Actual text of the text note
  String text = "";

  /// Local text of the note stored at creation
  String localText = "";

  /// Whether or not this text file is flagged as a favorite
  bool isFavorite = false;

  /// Date of event
  String eventDate = "";

  /// Date of event
  String eventTime = "";

  String toJson() {
    String jsonStr = """ {"noteId": "${this.noteId}",
                        "recordedTime": "${this.recordedTime}",
                        "language": "${this.language}",
                        "recurrentType": "${this.recurrentType}",
                        "isCheckList": ${this.isCheckList},
                        "isEvent": ${this.isEvent},
                        "text": "${this.text}",
                        "localText": "${this.localText}",
                        "isFavorite": ${this.isFavorite},
                        "eventDate": "${this.eventDate}",
                        "eventTime": "${this.eventTime}"
                        }""";
    return jsonStr;
  }

  factory TextNote.fromJson(dynamic jsonObj) {
    TextNote note = TextNote();
    print("extracting jsonObj $jsonObj");
    note.noteId = jsonObj['noteId'];
    note.recordedTime = DateTime.parse(jsonObj['recordedTime']);
    note.language = jsonObj['language'];
    note.isCheckList = jsonObj['isCheckList'];
    note.recurrentType = jsonObj['recurrentType'];
    note.isEvent = jsonObj['isEvent'];
    note.text = jsonObj['text'];
    note.localText = jsonObj['localText'];
    note.isFavorite = jsonObj['isFavorite'];
    note.eventDate = jsonObj['eventDate'] ?? "";
    note.eventTime = jsonObj['eventTime'] ?? "";
    return note;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
