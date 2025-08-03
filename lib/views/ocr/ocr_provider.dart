import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indoor_object_detection/views/ocr/ocr_controller.dart';
import 'package:indoor_object_detection/views/ocr/ocr_state.dart';

final ocrProvider = StateNotifierProvider<OcrController, OcrState>((ref) {
  return OcrController();
});
