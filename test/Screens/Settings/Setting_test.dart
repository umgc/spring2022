import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Settings/Setting.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:mockito/annotations.dart';

import 'Setting_test.mocks.dart';

Widget createWidgetForTesting(
    {required Widget child, required MockSettingObserver mockObs, required MenuObserver menuObs}) {
  final i18n = I18n.delegate;
  I18n.onLocaleChanged = (Locale locale) {
    null;
  };
  when(mockObs.userSettings).thenReturn(new Setting());

  return MultiProvider(
      providers: [
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

@GenerateMocks([SettingObserver, MenuObserver])
void main() {
  group('Settings - Widget', () {
    testWidgets('Settings Widget Finds All Default Text',
        (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(
          createWidgetForTesting(child: new Settings(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final saveButtonFinder = find.text('Save');
      final resetButtonFinder = find.text('Reset');
      final themeTextFinder = find.text('Blue');
      final cancelButtonFinder = find.text('Cancel');
      final englishLanguageFinder = find.text('English');
      final mediumTextFinder = find.text('Medium');
      expect(saveButtonFinder, findsOneWidget);
      expect(resetButtonFinder, findsOneWidget);
      expect(themeTextFinder, findsOneWidget);
      expect(cancelButtonFinder, findsOneWidget);
      expect(englishLanguageFinder, findsOneWidget);
      expect(mediumTextFinder, findsWidgets);
    });

    testWidgets('Click Save', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();

      await tester.pumpWidget(
          createWidgetForTesting(child: new Settings(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final saveButtonFinder = find.text('Save');
      await tester.tap(saveButtonFinder);
      verify(mockObs.saveSetting()).called(1);
    });

    testWidgets('Click Reset', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();

      await tester.pumpWidget(
          createWidgetForTesting(child: new Settings(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final resetButtonFinder = find.text('Reset');
      await tester.tap(resetButtonFinder);
      verify(mockObs.saveSetting()).called(1);
    });

    testWidgets('Click Cancel', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(
          createWidgetForTesting(child: new Settings(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final saveButtonFinder = find.text('Cancel');
      await tester.tap(saveButtonFinder);
      verify(menuObs.changeScreen(MENU_SCREENS.MENU)).called(1);
    });
  });
}
