import 'package:get/get.dart';
import 'package:indoor_object_detection/localization/en.dart';
import 'package:indoor_object_detection/localization/th.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'th': th,
  };
}