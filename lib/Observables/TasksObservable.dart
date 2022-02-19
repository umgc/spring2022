import 'package:mobx/mobx.dart';


part 'TasksObservable.g.dart';



class TasksObserver = _AbstractTasksObserver with _$TasksObserver;

abstract class _AbstractTasksObserver with Store {

  _AbstractTasksObserver(){
    print("In the _AbstractTasksObserver");
  }

  @observable
  String currentScreen = '';



}