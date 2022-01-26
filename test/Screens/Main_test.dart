import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/HelpObservable.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Main.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'Main_test.mocks.dart';

Widget createWidgetForTesting(
    {required Widget child, required MockMainNavObserver mainNavObs}) {
  final i18n = I18n.delegate;

  return MultiProvider(
      providers: [
        Provider<MicObserver>(create: (_) => MicObserver()),
        Provider<MainNavObserver>(create: (_) => mainNavObs),
        Provider<SettingObserver>(create: (_) => SettingObserver()),
        Provider<NoteObserver>(create: (_) => NoteObserver()),
        Provider<MenuObserver>(create: (_) => MenuObserver()),
        Provider<HelpObserver>(create: (_) => HelpObserver())
      ],
      child: MaterialApp(
        home: child,
        localizationsDelegates: [
          i18n,
        ],
      ));
}

@GenerateMocks([MainNavObserver, I18n])
void main() {
  var mockObserver = MockMainNavObserver();
  when(mockObserver.currentScreen).thenReturn(MAIN_SCREENS.MENU);
  when(mockObserver.focusedNavBtn).thenReturn('');
  when(mockObserver.screenTitle).thenReturn('');

  group('Widget', () {
    testWidgets(
        'MainNavigator finds all bottom navigation information - default',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();
      final menuButtonNameFinder = find.text('Menu');
      final notesButtonNameFinder = find.text('Notes');
      expect(menuButtonNameFinder, findsOneWidget);
      expect(notesButtonNameFinder, findsOneWidget);
    });

    testWidgets(
        'MainNavigator finds all bottom navigation information - spanish',
        (WidgetTester tester) async {
      I18n.locale = new Locale("es", "US");
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();
      final menuButtonNameFinder = find.text('Menú');
      final notesButtonNameFinder = find.text('Notas');
      expect(menuButtonNameFinder, findsOneWidget);
      expect(notesButtonNameFinder, findsOneWidget);
      I18n.locale = new Locale("en", "US");
    });

    testWidgets('Click Menu', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();
      final menuScreenNameFinder = find.text('Menu').first;
      await tester.tap(menuScreenNameFinder);
      verify(mockObserver.setTitle("Menu")).called(2); // OK: no arg matchers.
    });
  });
}
