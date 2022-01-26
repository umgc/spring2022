import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:untitled3/Model/Help.dart';

class HelpService {
  static const String FILE_NAME = "assets/help/help_content.json";

  /// Save a text note file to local storage
  static Future<List<HelpContent>> loadHelpContent() async {
    print("Loading help from file");
    List<HelpContent> helpContent = [];
    try {
      dynamic listExtract =  await rootBundle.loadString("$FILE_NAME").then((value) => jsonDecode(value));
      for (var help in listExtract) {
        print("Loading help from file $help");
        helpContent.add(HelpContent.fromJson(help));
      }
    } catch(exception) {
      print("Exception occurred while loading help content");
      print("$exception");
    }
    return helpContent;
  }

}