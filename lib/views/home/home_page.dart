import 'package:flutter/material.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/views/object_detection/object_detection_page.dart';
import 'package:indoor_object_detection/views/ocr/ocr_page.dart';
import 'package:indoor_object_detection/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(marginX2),
            child: Column(
              children: [
                Container(width: 100, height: 100, color: Colors.grey),
                SizedBox(height: marginX2),
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ObjectDetectionPage()),
                    );
                  },
                  iconPath: 'object_detect_icon.svg',
                  title: ' Object Detection',
                ),
                SizedBox(height: marginX2),
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OcrPage()),
                    );
                  },
                  iconPath: 'ocr_icon.svg',
                  title: ' OCR',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
