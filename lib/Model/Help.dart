import '../Services/NoteService.dart';

class HelpContent {
  HelpContent();

  /// Name of the text note file
  String helpId = TextNoteService.generateUUID();

  //title
  String title = "";
  String videoUrl = "";


  String toJson() {
    String jsonStr = """ {"title": "${this.title}",
                        "videoUrl": "${this.videoUrl}"}""";
    return jsonStr;
  }

  factory HelpContent.fromJson(dynamic jsonObj) {
    HelpContent helpContent = HelpContent();
    print("extracting jsonObj $jsonObj");
    helpContent.title = jsonObj['title'];
    helpContent.videoUrl = jsonObj['videoUrl'];
    return helpContent;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
