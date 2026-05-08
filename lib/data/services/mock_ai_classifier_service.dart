import 'dart:math';

import '../dummy/dummy_data.dart';
import '../models/scan_result.dart';

class MockAiClassifierService {
  Future<ScanResult> classifyImage(String imagePath) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final index = imagePath.hashCode.abs() % DummyData.scanResults.length;
    return DummyData.scanResults[index];
  }

  Future<ScanResult> classifyRandomDemo() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return DummyData.scanResults[Random().nextInt(DummyData.scanResults.length)];
  }
}
