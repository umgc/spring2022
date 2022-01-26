import 'package:mobx/mobx.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:untitled3/Screens/Onboarding/Permission.dart';
part 'OnboardObservable.g.dart';


class OnboardObserver = _AbstractOnboardObserver with _$OnboardObserver;

abstract class _AbstractOnboardObserver with Store {

  @observable
  int currentScreenIndex = 0;
  
  @observable
  bool micAccessAllowed = true;

  @observable
  var language;

  @observable
  int id = 2;

  @observable
  bool denied = true;



  @action
  void permissionYes(value) {
    this.id = value;
    this.denied = false;
  }



  @action
  void permissionNo(value){
    this.id =  value;
    this.denied = true;
}

  @action
  void languageChange(language){
    I18n.onLocaleChanged!(language!);

  }

   @action
  void setMicAccessAllowed(value){
    micAccessAllowed = value;
  }

  @action
  void moveToNextScreen(){
    currentScreenIndex = currentScreenIndex+1;
  }

  @action
  void moveToPrevScreen(){
    
    if(currentScreenIndex-1 < 0){
      return;
    }
    currentScreenIndex = currentScreenIndex-1;
  }

  @action
  void reset(){
    currentScreenIndex = 0;
  }

}