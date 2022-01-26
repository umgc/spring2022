// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HelpObservable.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HelpObserver on _AbstractHelpObserver, Store {
  final _$helpItemsAtom = Atom(name: '_AbstractHelpObserver.helpItems');

  @override
  List<HelpContent> get helpItems {
    _$helpItemsAtom.reportRead();
    return super.helpItems;
  }

  @override
  set helpItems(List<HelpContent> value) {
    _$helpItemsAtom.reportWrite(value, super.helpItems, () {
      super.helpItems = value;
    });
  }

  final _$loadHelpCotentAsyncAction =
      AsyncAction('_AbstractHelpObserver.loadHelpCotent');

  @override
  Future<void> loadHelpCotent() {
    return _$loadHelpCotentAsyncAction.run(() => super.loadHelpCotent());
  }

  @override
  String toString() {
    return '''
helpItems: ${helpItems}
    ''';
  }
}
