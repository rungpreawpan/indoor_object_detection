import 'package:indoor_object_detection/views/obstacle/model/obstacle_boxes_model.dart';

class ObstacleModel {
  List<ObstacleBoxesModel>? boxes;
  int? imageWidth;
  int? imageHeight;

  ObstacleModel({
    this.boxes,
    this.imageWidth,
    this.imageHeight,
  });

  factory ObstacleModel.fromJSON(Map<String, dynamic> json) {
    return ObstacleModel(
      boxes:
          List.from(json['boxes']).map((e) => ObstacleBoxesModel.fromJSON(e)).toList(),
      imageWidth: int.parse(json['image_width'].toString()),
      imageHeight: int.parse(json['image_height'].toString()),
    );
  }
}
