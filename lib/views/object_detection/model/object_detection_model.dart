import 'package:indoor_object_detection/views/object_detection/model/boxes_model.dart';

class ObjectDetectionModel {
  List<BoxesModel>? boxes;
  int? imageWidth;
  int? imageHeight;

  ObjectDetectionModel({
    this.boxes,
    this.imageWidth,
    this.imageHeight,
  });

  factory ObjectDetectionModel.fromJSON(Map<String, dynamic> json) {
    return ObjectDetectionModel(
      boxes:
          List.from(json['boxes']).map((e) => BoxesModel.fromJSON(e)).toList(),
      imageWidth: int.parse(json['image_width'].toString()),
      imageHeight: int.parse(json['image_height'].toString()),
    );
  }
}