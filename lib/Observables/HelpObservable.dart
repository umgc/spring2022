import 'package:mobx/mobx.dart';
import 'package:memorez/Model/Help.dart';
import 'package:memorez/Services/HelpService.dart';
part 'HelpObservable.g.dart';

class HelpObserver = _AbstractHelpObserver with _$HelpObserver;

abstract class _AbstractHelpObserver with Store {

  @observable
  List<HelpContent>  helpItems = [];

  @action
  Future<void> loadHelpCotent() async {
    helpItems = await HelpService.loadHelpContent();
  }

}
