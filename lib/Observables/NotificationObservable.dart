import 'package:mobx/mobx.dart';
import 'package:untitled3/Screens/NotificationScreen.dart';

part 'NotificationObservable.g.dart';

class NotificationObserver = _AbstractNotificationObserver with _$NotificationObserver;

abstract class _AbstractNotificationObserver with Store {


  @observable
  bool onWalking = false;

  @observable
  bool onWater = false;

  @observable
  bool reminder = false;

  @observable
  bool Bathroom = false;

  @observable
  bool noteNotification = false;

  @action
  void NoteNotification(value) {
    this.noteNotification = value;
  }

  @action
  void NotificationWalk(value) {
    this.onWalking = value;
    if (this.onWalking) {
      repeatNotificationWalk();
    }
  }

  @action
  void NotificationWater(value) {
    this.onWater = value;
  }

  @action
  void NotificationReminder(value) {
    this.reminder = value;
  }

  @action
  void NotificationBathroom(value) {
    this.Bathroom = value;
    if (this.Bathroom) {
      repeatNotificationBathroom();
    }
  }
}

