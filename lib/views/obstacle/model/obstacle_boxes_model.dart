class ObstacleBoxesModel {
  String? label;
  double? confidence;
  double? x1;
  double? y1;
  double? x2;
  double? y2;
  double? medianDepth;
  String? direction;
  double? priority;
  String? message;

  ObstacleBoxesModel({
    this.label,
    this.confidence,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
    this.medianDepth,
    this.direction,
    this.priority,
    this.message,
  });

  factory ObstacleBoxesModel.fromJSON(Map<String, dynamic> json) {
    return ObstacleBoxesModel(
      label: json['label'],
      confidence: json['confidence'],
      x1: double.parse(json['x1'].toString()),
      y1: double.parse(json['y1'].toString()),
      x2: double.parse(json['x2'].toString()),
      y2: double.parse(json['y2'].toString()),
      medianDepth: json['median_depth'],
      direction: json['direction'],
      priority: json['priority'],
      message: json['message'],
    );
  }
}