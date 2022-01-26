import 'dart:ffi';
import 'dart:io';
import 'package:quiver/check.dart';

import '../../../Common/FileUtilService.dart';
import '../../../Task/Bindings/Text/QA/BertQaService.dart';
import '../../../Task/Bindings/Text/QA/TypesService.dart';
import 'package:ffi/ffi.dart';
import 'QuestionAnswererService.dart';

import 'QAAnswer.dart';

/// Task API for BertQA models. */
class BertQuestionAnswererTaskService implements QuestionAnswerer {
  final Pointer<TfLiteBertQuestionAnswerer> _classifier;
  bool _deleted = false;
  Pointer<TfLiteBertQuestionAnswerer> get base => _classifier;

  BertQuestionAnswererTaskService._(this._classifier);

  /// Generic API to create the QuestionAnswerer for bert models with metadata populated. The API
  /// expects a Bert based TFLite model with metadata containing the following information:
  ///
  /// <ul>
  ///   <li>input_process_units for Wordpiece/Sentencepiece Tokenizer - Wordpiece Tokenizer can be
  ///       used for a <a
  ///       href="https://tfhub.dev/tensorflow/lite-model/mobilebert/1/default/1">MobileBert</a>
  ///       model, Sentencepiece Tokenizer Tokenizer can be used for an <a
  ///       href="https://tfhub.dev/tensorflow/lite-model/albert_lite_base/squadv1/1">Albert</a>
  ///       model.
  ///   <li>3 input tensors with names "ids", "mask" and "segment_ids".
  ///   <li>2 output tensors with names "end_logits" and "start_logits".
  /// </ul>
  ///
  /// Creates [BertQuestionAnswerer] from [modelPath].
  ///
  /// [modelPath] is the path of the .tflite model loaded on device.
  ///
  /// throws [FileSystemException] If model file fails to load.
  static BertQuestionAnswererTaskService create(String modelPath) {
    final nativePtr = BertQuestionAnswererFromFile(modelPath.toNativeUtf8());
    if (nativePtr == nullptr) {
      throw FileSystemException(
          "Failed to create BertQuestionAnswererService.", modelPath);
    }
    return BertQuestionAnswererTaskService._(nativePtr);
  }

  /// Generic API to create the QuestionAnswerer for bert models with metadata populated. The API
  /// expects a Bert based TFLite model with metadata containing the following information:
  ///
  /// <ul>
  ///   <li>input_process_units for Wordpiece/Sentencepiece Tokenizer - Wordpiece Tokenizer can be
  ///       used for a <a
  ///       href="https://tfhub.dev/tensorflow/lite-model/mobilebert/1/default/1">MobileBert</a>
  ///       model, Sentencepiece Tokenizer Tokenizer can be used for an <a
  ///       href="https://tfhub.dev/tensorflow/lite-model/albert_lite_base/squadv1/1">Albert</a>
  ///       model.
  ///   <li>3 input tensors with names "ids", "mask" and "segment_ids".
  ///   <li>2 output tensors with names "end_logits" and "start_logits".
  /// </ul>
  ///
  /// Create [BertQuestionAnswererTaskService] from [modelFile].
  ///
  /// throws [FileSystemException] If model file fails to load.
  static BertQuestionAnswererTaskService createFromFile(File modelFile) {
    return create(modelFile.path);
  }

  /// Create [BertQuestionAnswererTaskService] directly from [assetPath].
  ///
  /// [assetPath] must the full path to assets. Eg. 'assets/my_model.tflite'.
  ///
  /// throws [FileSystemException] If model file fails to load.
  static Future<BertQuestionAnswererTaskService> createFromAsset(String assetPath) async {
    final modelFile = await FileUtilService.loadFileOnDevice(assetPath);
    return create(modelFile.path);
  }

  @override
  List<QaAnswer> answer(String context, String question) {
    final ref = BertQuestionAnswererAnswer(
        base, context.toNativeUtf8(), question.toNativeUtf8())
        .ref;
    final qaList = List.generate(
      ref.size,
          (i) => QaAnswer(
        Pos(ref.answers[i].start, ref.answers[i].end, ref.answers[i].logit),
        ref.answers[i].text.toDartString(),
      ),
    );
    return qaList;
  }

  /// Deletes BertQuestionAnswererService native instance.
  void delete() {
    checkState(!_deleted, message: 'NLCLassifier already deleted.');
    BertQuestionAnswererDelete(base);
    _deleted = true;
  }
}


