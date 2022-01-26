import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'BertQAHelperService.dart';

class BertQAService {
  late final BertQuestionAnswererTaskService bertQuestionAnswerer;

  final _modelPath = "lite-model_mobilebert_1_metadata_1.tflite";

  BertQAService () {
    createClassifier();
  }

  Future<void> createClassifier() async {
    final onDevicePath = await getPathOnDevice(_modelPath);
    bertQuestionAnswerer = BertQuestionAnswererTaskService.create(onDevicePath);
  }

  List<QaAnswer> answer(String context, String question) {
    return bertQuestionAnswerer.answer(context, question);
  }
}

Future<File> getFile(String fileName) async {
  final appDir = await getTemporaryDirectory();
  final appPath = appDir.path;
  final fileOnDevice = File('$appPath/$fileName');
  final rawAssetFile = await rootBundle.load('assets/NLU/$fileName');
  final rawBytes = rawAssetFile.buffer.asUint8List();
  await fileOnDevice.writeAsBytes(rawBytes, flush: true);
  return fileOnDevice;
}

Future<String> getPathOnDevice(String assetFileName) async {
  final fileOnDevice = await getFile(assetFileName);
  return fileOnDevice.path;
}