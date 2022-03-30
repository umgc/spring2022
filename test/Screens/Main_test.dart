import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:memorez/Observables/HelpObservable.dart';
import 'package:memorez/Observables/MenuObservable.dart';
import 'package:memorez/Observables/MicObservable.dart';
import 'package:memorez/Observables/NoteObservable.dart';
import 'package:memorez/Observables/ScreenNavigator.dart';
import 'package:memorez/Observables/SettingObservable.dart';
import 'package:memorez/Screens/Main.dart';
import 'package:memorez/Utility/Constant.dart';
import 'package:memorez/generated/i18n.dart';
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
      final chatButtonNameFinder = find.text('Chat');
      final helpButtonNameFinder = find.text('Help');

      expect(menuButtonNameFinder, findsOneWidget);
      expect(chatButtonNameFinder, findsOneWidget);
      expect(helpButtonNameFinder, findsOneWidget);

    });

    testWidgets(
        'MainNavigator finds all bottom navigation information - spanish',
        (WidgetTester tester) async {
      I18n.locale = new Locale("es", "US");
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();

      final menuButtonNameFinder = find.text('Menú');
      final chatButtonNameFinder = find.text('Chat');
      final helpButtonNameFinder = find.text('Ayudar');

      expect(menuButtonNameFinder, findsOneWidget);
      expect(chatButtonNameFinder, findsOneWidget);
      expect(helpButtonNameFinder, findsOneWidget);

      I18n.locale = new Locale("en", "US");
    });

    testWidgets(
        'MainNavigator finds all bottom navigation information - arabic',
        (WidgetTester tester) async {
      I18n.locale = new Locale("ar", "SY");
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();

      final menuButtonNameFinder = find.text('الصفحة القائمة');
      final chatButtonNameFinder = find.text('دردشة');
      final helpButtonNameFinder = find.text('يساعد');

      expect(menuButtonNameFinder, findsOneWidget);
      expect(chatButtonNameFinder, findsOneWidget);
      expect(helpButtonNameFinder, findsOneWidget);

      I18n.locale = new Locale("en", "US");
    });



    testWidgets(
        'MainNavigator finds all bottom navigation information - portuguese',
        (WidgetTester tester) async {
      I18n.locale = new Locale("pt", "BR");
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();

      final menuButtonNameFinder = find.text('Cardápio');
      final chatButtonNameFinder = find.text('bater papo');
      final helpButtonNameFinder = find.text('Ajuda');

      expect(menuButtonNameFinder, findsOneWidget);
      expect(chatButtonNameFinder, findsOneWidget);
      expect(helpButtonNameFinder, findsOneWidget);

      I18n.locale = new Locale("en", "US");
    });



    testWidgets(
        'MainNavigator finds all bottom navigation information - chinese',
        (WidgetTester tester) async {
      I18n.locale = new Locale("zh", "CN");
      await tester.pumpWidget(createWidgetForTesting(
          child: new MainNavigator(), mainNavObs: mockObserver));
      await tester.pumpAndSettle();

      final menuButtonNameFinder = find.text('菜单');
      final chatButtonNameFinder = find.text('聊天');
      final helpButtonNameFinder = find.text('帮助');

      expect(menuButtonNameFinder, findsOneWidget);
      expect(chatButtonNameFinder, findsOneWidget);
      expect(helpButtonNameFinder, findsOneWidget);

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