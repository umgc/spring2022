import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:quiver/check.dart';
import '../../../Task/Bindings/Text/NL_Classifier/TypesService.dart';

class BertNLClassifierOptionsService {
  final Pointer<TfLiteBertNLClassifierOptions> _options;
  bool _deleted = false;
  Pointer<TfLiteBertNLClassifierOptions> get base => _options;

  BertNLClassifierOptionsService._(this._options);

  static const int DEFAULT_MAX_SEQ_LEN = 128;

  /// Creates a new options instance.
  factory BertNLClassifierOptionsService() {
    final optionsPtr = TfLiteBertNLClassifierOptions.allocate(DEFAULT_MAX_SEQ_LEN);
    return BertNLClassifierOptionsService._(optionsPtr);
  }

  int get maxSeqLen => base.ref.maxSeqLen;

  set maxSeqLen(int value) {
    base.ref.maxSeqLen = value;
  }

  /// Destroys the options instance.
  void delete() {
    checkState(!_deleted, message: 'BertNLClassifierOptions already deleted.');
    calloc.free(_options);
    _deleted = true;
  }
}