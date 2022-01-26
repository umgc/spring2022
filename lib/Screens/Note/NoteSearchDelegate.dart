import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';

import 'NoteTable.dart';

class NoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: NoteSearchDelegate(),
            );
          },
          child: Icon(
            Icons.close,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          close(context, null);
        },
        child: Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    List<TextNote> filteredResult = noteObserver.onSearchNote(query);
    return NoteTable(filteredResult, () => {close(context, null)});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("Do something with the search $query");
    final noteObserver = Provider.of<NoteObserver>(context);
    List<TextNote> filteredResult = noteObserver.onSearchNote(query);
    return NoteTable(filteredResult, () => {close(context, null)});
  }
}
/**
 * Should we show daily checklist items in event calendar?
 */