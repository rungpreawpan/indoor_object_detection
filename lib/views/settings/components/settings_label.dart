import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

enum SettingsLabelStyle {
  onOff,
  interact,
  showData,
  updateInfo,
}

class SettingsLabel extends StatefulWidget {
  final String title;
  final SettingsLabelStyle settingsLabelStyle;
  final bool switchValue;
  final Function(bool)? onChanged;
  final Function()? onTap;
  final String buttonInitialValue;
  final bool showWarning;

  const SettingsLabel({
    super.key,
    required this.title,
    required this.settingsLabelStyle,
    this.switchValue = false,
    this.onChanged,
    this.onTap,
    this.buttonInitialValue = '',
    this.showWarning = false,
  });

  @override
  State<SettingsLabel> createState() => _SettingsLabelState();
}

class _SettingsLabelState extends State<SettingsLabel> {
  @override
  Widget build(BuildContext context) {
    return getLabelStyle(context);
  }

  Widget getLabelStyle(BuildContext context) {
    Widget labelStyle;
    SettingsLabelStyle label = widget.settingsLabelStyle;

    switch (label) {
      case SettingsLabelStyle.onOff:
        labelStyle = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFontStyle(
              widget.title,
              size: fontSizeL,
            ),
            _switch(
              value: widget.switchValue,
              onChanged: widget.onChanged,
            ),
          ],
        );
        break;

      case SettingsLabelStyle.interact:
        labelStyle = InkWell(
          onTap: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFontStyle(
                widget.title,
                size: fontSizeL,
              ),
              widget.buttonInitialValue != ''
                  ? TextFontStyle(
                      widget.buttonInitialValue,
                      size: fontSizeL,
                      weight: FontWeight.bold,
                    )
                  : const SizedBox(
                      width: 20.0,
                      child: Icon(
                        Icons.navigate_next_rounded,
                        size: 30.0,
                      ),
                    ),
            ],
          ),
        );
        break;

      case SettingsLabelStyle.showData:
        labelStyle = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFontStyle(
              widget.title,
              size: fontSizeL,
            ),
            TextFontStyle(
              widget.buttonInitialValue,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
          ],
        );
        break;

      case SettingsLabelStyle.updateInfo:
        labelStyle = InkWell(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFontStyle(
                widget.title,
                size: fontSizeM,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextFontStyle(
                        widget.buttonInitialValue,
                        size: fontSizeL,
                        weight: FontWeight.bold,
                      ),
                      Visibility(
                        visible: widget.showWarning,
                        child: const Row(
                          children: [
                            SizedBox(width: margin),
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.0,
                    child: Icon(
                      Icons.navigate_next_rounded,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
    }

    return labelStyle;
  }

  _switch({
    required bool value,
    void Function(bool)? onChanged,
  }) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: primaryColor,
    );
  }
}
