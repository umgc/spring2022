import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';
part 'ScreenNavigator.g.dart';
class MainNavObserver = _AbstractMainNavObserver with _$MainNavObserver;

abstract class _AbstractMainNavObserver with Store {

  @observable
  dynamic currentScreen;

  @observable
  String screenTitle ="";

  @observable
  dynamic focusedNavBtn = 0;

  @action
  void changeScreen(dynamic screen){
    print("Screen changed to: $screen");
    currentScreen = screen;
    focusedNavBtn = -1;
  }

  @action
  void setTitle(String title){
    print("Change Screen tittle to: "+ title);
    screenTitle = title;
    
  }

  @action
  void setFocusedBtn(dynamic focusedBtn){
    focusedNavBtn = focusedBtn;
    if(focusedBtn == 2) currentScreen = MAIN_SCREENS.NOTE;
    if(focusedBtn == 0) currentScreen = MAIN_SCREENS.MENU;
  }

}