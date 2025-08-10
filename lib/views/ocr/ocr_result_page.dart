import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/tts_manager.dart';
import 'package:indoor_object_detection/views/ocr/controller/ocr_controller.dart';
import 'package:indoor_object_detection/views/settings/model/settings_model.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class OcrResultPage extends StatefulWidget {
  final File imageFile;

  const OcrResultPage({
    super.key,
    required this.imageFile,
  });

  @override
  State<OcrResultPage> createState() => _OcrResultPageState();
}

class _OcrResultPageState extends State<OcrResultPage> {
  final OcrController _ocrController = Get.find();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final ttsManager = TtsManager();

  SettingsModel? settingsInfo;

  @override
  void initState() {
    super.initState();

    _speak();
  }

  Future _speak() async {
    if (_ocrController.ocrText?.text != null) {
      await ttsManager.speak(_ocrController.ocrText!.text!);
    }
  }

  @override
  void dispose() {
    super.dispose();

    ttsManager.stop();
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'scan result'.tr,
      showBackButton: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(marginX2),
            child: Column(
              children: [
                Image.file(
                  widget.imageFile,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: marginX2),
                TextFontStyle(
                  _ocrController.ocrText != null
                      ? _ocrController.ocrText!.text!
                      : '',
                  size: fontSizeM,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
