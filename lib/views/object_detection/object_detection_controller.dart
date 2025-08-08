import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indoor_object_detection/views/object_detection/object_detection_state.dart';

class ObjectDetectionController extends StateNotifier<ObjectDetectionState> {
  ObjectDetectionController() :super(const ObjectDetectionState());
}