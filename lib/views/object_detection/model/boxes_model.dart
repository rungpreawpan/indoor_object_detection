class BoxesModel {
  String? label;
  double? confidence;
  double? x1;
  double? y1;
  double? x2;
  double? y2;

  BoxesModel({
    this.label,
    this.confidence,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
  });

  factory BoxesModel.fromJSON(Map<String, dynamic> json) {
    return BoxesModel(
      label: json['label'],
      confidence: json['confidence'],
      x1: double.parse(json['x1'].toString()),
      y1: double.parse(json['y1'].toString()),
      x2: double.parse(json['x2'].toString()),
      y2: double.parse(json['y2'].toString()),
    );
  }
}