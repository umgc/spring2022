import 'package:mobx/mobx.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Services/SettingService.dart';
import 'package:untitled3/generated/i18n.dart';

part 'SettingObservable.g.dart';

class SettingObserver = _AbstractSettingObserver with _$SettingObserver;

abstract class _AbstractSettingObserver with Store {

  _AbstractSettingObserver(){
    SettingService.loadSetting().then((value) => initSettings(value));
  }

  @observable
  String currentScreen = "";

  @observable 
  Setting userSettings = Setting(); 


  @action
  void saveSetting(){
     //over-write old settings with incoming new one.
     SettingService.save(userSettings); 
  }

  @action
  void initSettings(settings){
    print("Initialize settings : ${settings}");
    userSettings = settings;
    I18n.onLocaleChanged!(settings.locale ?? DEFAULT_LOCALE);
  }

  @action
  void changeScreen(String name){
    print("Setting Screen changed to: "+ name);
    currentScreen = name;
  }

  @action 
  void setIsFirstRun(bool value){
    userSettings.isFirstRun = value;
  }
  
}

