import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Screens/Menu/Menu.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:mockito/annotations.dart';

import 'Menu_test.mocks.dart';

Widget createWidgetForTesting(
    {required Widget child,
    required MockSettingObserver mockObs,
    required MenuObserver menuObs}) {
  final i18n = I18n.delegate;
  when(menuObs.currentScreen).thenReturn(MENU_SCREENS.MENU);
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
    testWidgets('Menu Widget Finds All Default Text',
        (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();

      await tester.pumpWidget(createWidgetForTesting(
          child: new Menu(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final settingButton = find.text('Settings');
      final syncToCloudButton = find.text('Sync to Cloud');
      final triggerButton = find.text('Trigger');
      final helpButton = find.text('Help');

      expect(settingButton, findsOneWidget);
      expect(syncToCloudButton, findsOneWidget);
      expect(triggerButton, findsOneWidget);
      expect(helpButton, findsOneWidget);
    });

    testWidgets('Click Setting', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(createWidgetForTesting(
          child: new Menu(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final settingButton = find.text('Settings');
      await tester.tap(settingButton);
      verify(menuObs.changeScreen(MENU_SCREENS.GENERAL_SETTING)).called(1);
    });

    testWidgets('Click Sync To Cloud', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(createWidgetForTesting(
          child: new Menu(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final settingButton = find.text('Sync to Cloud');
      await tester.tap(settingButton);
      verifyNever(menuObs.changeScreen(MENU_SCREENS.SYNC_TO_CLOUD));
    });

    testWidgets('Click Help', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(createWidgetForTesting(
          child: new Menu(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final button = find.text('Help');
      await tester.tap(button);
      verify(menuObs.changeScreen(MENU_SCREENS.HELP)).called(1);
    });

    testWidgets('Click Trigger', (WidgetTester tester) async {
      final mockObs = MockSettingObserver();
      final menuObs = MockMenuObserver();
      await tester.pumpWidget(createWidgetForTesting(
          child: new Menu(), mockObs: mockObs, menuObs: menuObs));
      await tester.pumpAndSettle();
      final button = find.text('Trigger');
      await tester.tap(button);
      verify(menuObs.changeScreen(MENU_SCREENS.TRIGGER)).called(1);
    });

  });
}
