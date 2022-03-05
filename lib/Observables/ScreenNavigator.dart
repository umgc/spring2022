import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';

part 'ScreenNavigator.g.dart';

class MainNavObserver = _AbstractMainNavObserver with _$MainNavObserver;

abstract class _AbstractMainNavObserver with Store {
  @observable
  dynamic currentScreen;

  @observable
  String screenTitle = "";

  @observable
  dynamic focusedNavBtn = 0;

  @action
  void changeScreen(dynamic screen) {
    print("Screen changed to: $screen");
    currentScreen = screen;
    focusedNavBtn = -1;
    // if (screen == MAIN_SCREENS.MENU) {
    //   currentScreen = screen;
    //   focusedNavBtn = 0;
    // } else if (screen == MAIN_SCREENS.HOME) {
    //   currentScreen = screen;
    //   focusedNavBtn = 1;
    // } else if (screen == MENU_SCREENS.HELP) {
    //   currentScreen = screen;
    //   focusedNavBtn = 2;
    // }
  }

  @action
  void setTitle(String title) {
    print("Change Screen title to: " + title);
    screenTitle = title;
  }

  @action
  void setFocusedBtn(dynamic focusedBtn) {
    focusedNavBtn = focusedBtn;

    if (focusedBtn == 2) currentScreen = MENU_SCREENS.HELP;
    if (focusedBtn == 0) currentScreen = MAIN_SCREENS.MENU;
    if (focusedBtn == 1) currentScreen = MAIN_SCREENS.HOME;
  }
}
