import 'package:freezed_annotation/freezed_annotation.dart';
import 'ocr_model.dart';

part 'ocr_state.freezed.dart';

@freezed
class OcrState with _$OcrState {
  const factory OcrState({
    @Default(false) bool isLoading,
    OcrModel? ocrText,
  }) = _OcrState;

  @override
  bool get isLoading => throw UnimplementedError();

  @override
  OcrModel? get ocrText => throw UnimplementedError();
}
