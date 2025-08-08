import 'package:freezed_annotation/freezed_annotation.dart';
import 'ocr_model.dart';

part 'ocr_state.freezed.dart';

@freezed
abstract class OcrState with _$OcrState {
  const factory OcrState({
    @Default(false) bool isLoading,
    OcrModel? ocrText,
  }) = _OcrState;

  const OcrState._();
}