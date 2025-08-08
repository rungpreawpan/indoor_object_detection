import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/widgets/custom_back_button.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class CustomTemplate extends ConsumerWidget {
  final String title;
  final bool showBackButton;
  final bool centerTitle;
  final Widget body;

  const CustomTemplate({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.centerTitle = true,
    required this.body,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: TextFontStyle(
          title,
          size: fontAppbar,
          weight: FontWeight.bold,
          color: primaryColor,
        ),
        leading: showBackButton ? CustomBackButton() : SizedBox(),
        centerTitle: centerTitle,
        backgroundColor: Colors.white,
        toolbarHeight: 90.0,
        elevation: 0.0,
      ),
      body: SizedBox.expand(child: body),
    );
  }
}
