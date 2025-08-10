import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/widgets/custom_back_button.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class MainTemplate extends StatefulWidget {
  final String appBarTitle;
  final bool showBackButton;
  final Function()? onBack;
  final List<Widget>? actions;
  final Widget? body;
  final Widget? floatingActionButton;

  const MainTemplate({
    super.key,
    this.appBarTitle = '',
    this.showBackButton = false,
    this.onBack,
    this.actions,
    this.body,
    this.floatingActionButton,
  });

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: widget.appBarTitle != '' && widget.showBackButton
            ? TextFontStyle(
                widget.appBarTitle,
                size: fontAppbar,
                weight: FontWeight.bold,
                align: TextAlign.center,
              )
            : Image.asset(
                'assets/logo/appbar_logo.png',
                width: 200,
              ),
        leading: Visibility(
          visible: widget.showBackButton,
          child: CustomBackButton(
            onTap: () {
              if (widget.onBack != null) {
                widget.onBack!();
              }

              Get.back();
            },
          ),
        ),
        actions: widget.actions,
        centerTitle: true,
        toolbarHeight: 90.0,
        elevation: 0.0,
      ),
      body: SizedBox.expand(child: widget.body),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
