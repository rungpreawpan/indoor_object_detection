class SettingsModel {
  bool? useSpeechRecognition;
  String? speed;
  String? language;

  SettingsModel({
    this.useSpeechRecognition,
    this.speed,
    this.language,
  });

  factory SettingsModel.fromJSON(Map<String, dynamic> json) {
    return SettingsModel(
      useSpeechRecognition: json['use_speech_recognition'],
      speed: json['speed'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'use_speech_recognition': useSpeechRecognition,
      'speed': speed,
      'language': language,
    };
  }
}
