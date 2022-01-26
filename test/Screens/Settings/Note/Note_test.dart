import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:mockito/annotations.dart';

import 'Note_test.mocks.dart';

Widget createWidgetForTesting(
    {required Widget child,
    required MockNoteObserver noteObs,
    required MockSettingObserver mockObs,
    required MenuObserver menuObs}) {
  final i18n = I18n.delegate;
  when(mockObs.userSettings).thenReturn(new Setting());
  return MultiProvider(
      providers: [
        Provider<NoteObserver>(create: (_) => noteObs),
        Provider<SettingObserver>(create: (_) => mockObs),
        Provider<MenuObserver>(create: (_) => menuObs)
      ],
      child: MaterialApp(
        home: child,
        localizationsDelegates: [
          i18n,
        ],
      ));
}


@GenerateMocks([SettingObserver, MenuObserver, NoteObserver])
void main() {
  group('Note - Details - Widget', () {
    testWidgets('Note Widget Finds All Default Text',
        (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final noteObs = MockNoteObserver();
      final menuObs = MockMenuObserver();
      when(noteObs.currentScreen).thenReturn(NOTE_SCREENS.NOTE_DETAIL);
      when(noteObs.newNoteIsCheckList).thenReturn(false);

      final expected = new TextNote();
      expected.localText = 'Hello World';
      expected.text = 'Hello World';
      when(noteObs.currNoteForDetails).thenReturn(expected);
      await tester.pumpWidget(createWidgetForTesting(
          child: new Note(),
          noteObs: noteObs,
          mockObs: mockObs,
          menuObs: menuObs));
      await tester.pumpAndSettle();
      final textFinder = find.text('Hello World');
      final cancelButtonFinder = find.text('Cancel');
      final saveNoteFinder = find.text('Save Note');
      final deleteNoteFinder = find.text('Delete Note');
      expect(textFinder, findsOneWidget);
      expect(cancelButtonFinder, findsOneWidget);
      expect(saveNoteFinder, findsOneWidget);
      expect(deleteNoteFinder, findsOneWidget);
    });
  });
}
