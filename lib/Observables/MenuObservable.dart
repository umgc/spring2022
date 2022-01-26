import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';
part 'MenuObservable.g.dart';

class MenuObserver = _AbstractMenuObserver with _$MenuObserver;

abstract class _AbstractMenuObserver with Store {

  @observable
  dynamic currentScreen = MENU_SCREENS.MENU;

  @observable
  String focusedIcon = "";

  @action
  void changeScreen(dynamic screen){
    currentScreen = screen;
  }

}
