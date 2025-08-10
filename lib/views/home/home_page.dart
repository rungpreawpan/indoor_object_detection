import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/views/object_detection/object_detection_page.dart';
import 'package:indoor_object_detection/views/ocr/ocr_page.dart';
import 'package:indoor_object_detection/views/settings/controller/settings_controller.dart';
import 'package:indoor_object_detection/widgets/custom_button.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppInfoController _appInfoController = Get.find();
  final SettingsController _settingsController = Get.find();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  final stt.SpeechToText _speech = stt.SpeechToText();

  List featuresList = [
    {
      'title': 'object detection'.tr,
      'icon_path': 'assets/icons/object_detect_icon.svg'
    },
    {'title': 'scan text'.tr, 'icon_path': 'assets/icons/ocr_icon.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      body: featuresList.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(marginX2),
              physics: const BouncingScrollPhysics(),
              itemCount: featuresList.length,
              itemBuilder: (context, index) {
                var item = featuresList[index];

                return CustomButton(
                  onTap: () async {
                    if (item['title'] == 'object detection'.tr) {
                      Get.to(() => const ObjectDetectionPage());
                    } else if (item['title'] == 'scan text'.tr) {
                      Get.to(() => const OcrPage());
                    } else {
                      Get.offAll(() => const HomePage());
                    }
                  },
                  iconPath: item['icon_path'],
                  title: item['title'],
                  showArrow: false,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: marginX2);
              },
            )
          : Center(
              child: TextFontStyle(
                'data not found'.tr,
                size: fontSizeM,
              ),
            ),
    );
  }
}
