import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import '../../Bindings/Text/NL_Classifier/BertNLClassifierService.dart';
import '../../Bindings/Text/NL_Classifier/TypesService.dart';
import '../../../Task/Text/NL_Classifier/BertNLClassfierOptionsService.dart';
import '../../../Common/FileUtilService.dart';

class BertNLClassifierService {
  final Pointer<TfLiteBertNLClassifier> _classifier;
  Pointer<TfLiteBertNLClassifier> get base => _classifier;

  BertNLClassifierService._(this._classifier);

  /// Create [BertNLClassifierService] from [modelPath] and optional [options].
  ///
  /// [modelPath] is the path of the .tflite model loaded on device.
  ///
  /// throws [FileSystemException] If model file fails to load.
  static BertNLClassifierService create(String modelPath,
      {BertNLClassifierOptionsService? options}) {
    if (options == null) {
      options = BertNLClassifierOptionsService();
    }
    final nativePtr = BertNLClassifierFromFileAndOptions(
        modelPath.toNativeUtf8(), options.base);
    if (nativePtr == nullptr) {
      throw FileSystemException(
          "Failed to create BertNLClassifierService.", modelPath);
    }
    return BertNLClassifierService._(nativePtr);
  }

  /// Create [BertNLClassifierService] from [modelFile].
  ///
  /// throws [FileSystemException] If model file fails to load.
  static BertNLClassifierService createFromFile(File modelFile) {
    return create(modelFile.path);
  }


  /// Create [BertNLClassifierService] from [modelFile] and [options].
  ///
  /// throws [FileSystemException] If model file fails to load.
  static BertNLClassifierService createFromFileAndOptions(
      File modelFile, BertNLClassifierOptionsService options) {
    return create(modelFile.path, options: options);
  }

  /// Create [BertNLClassifierService] directly from [assetPath] and optional [options].
  ///
  /// [assetPath] must the full path to assets. Eg. 'assets/my_model.tflite'.
  ///
  /// throws [FileSystemException] If model file fails to load.
  static Future<BertNLClassifierService> createFromAsset(String assetPath,
      {BertNLClassifierOptionsService? options}) async {
    final modelFile = await FileUtilService.loadFileOnDevice(assetPath);
    return create(modelFile.path, options: options);
  }

}
