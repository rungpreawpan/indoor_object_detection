import 'package:freezed_annotation/freezed_annotation.dart';
import 'object_detection_model.dart';

part 'object_detection_state.freezed.dart';

@freezed
abstract class ObjectDetectionState with _$ObjectDetectionState {
  const factory ObjectDetectionState({
    @Default(false) bool isLoading,
    ObjectDetectionModel? objectDetection,
  }) = _ObjectDetectionState;

  const ObjectDetectionState._();
}