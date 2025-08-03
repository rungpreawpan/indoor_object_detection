class OcrModel {
  final String? text;
  final String? language;
  final DateTime? timestamp;

  const OcrModel({
    this.text,
    this.language,
    this.timestamp,
  });

  factory OcrModel.fromJSON(Map<String, dynamic> json) {
    DateTime? timestamp;

    if (json['timestamp'] != null) {
      timestamp = DateTime.tryParse(json['timestamp'].toString());
    }

    return OcrModel(
      text: json['text'],
      language: json['lang'],
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'lang': language,
        'timestamp': timestamp?.toIso8601String(),
      };
}
