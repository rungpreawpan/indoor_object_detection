import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/widgets/custom_submit_button.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class CustomOkCancelDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Color? titleColor;
  final double titleSize;
  final Widget? content;
  final Color? contentColor;
  final Function()? onOK;
  final String? okText;
  final bool isGradient;
  final Color? gradientColor1;
  final Color? gradientColor2;
  final bool showCancel;
  final Function()? onCancel;
  final String? cancelText;
  final bool showClosedButton;

  const CustomOkCancelDialog({
    super.key,
    this.icon,
    required this.title,
    this.titleColor,
    this.titleSize = fontSizeL,
    this.content,
    this.contentColor,
    this.onOK,
    this.okText,
    this.isGradient = false,
    this.gradientColor1,
    this.gradientColor2,
    this.showCancel = true,
    this.onCancel,
    this.cancelText,
    this.showClosedButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: marginX2,
        right: marginX2,
        top: marginX2,
        bottom: margin,
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: showClosedButton ? marginX2 : 0.0),
                icon ?? SizedBox(),
                SizedBox(height: icon != null ? margin : 0.0),
                TextFontStyle(
                  title,
                  color: titleColor ?? Colors.black,
                  size: titleSize,
                  weight: FontWeight.bold,
                  align: TextAlign.center,
                ),
                SizedBox(height: content != null ? margin : 0.0),
                content ?? SizedBox(),
                SizedBox(height: showClosedButton ? marginX2 : 0.0),
              ],
            ),
            Visibility(
              visible: showClosedButton,
              child: Positioned(
                right: 0,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomSubmitButton(
                onTap: () {
                  Get.back(result: true);

                  if (onOK != null) {
                    onOK!();
                  }
                },
                title: okText ?? 'confirm'.tr,
                borderRadius: 10,
                buttonHeight: 45.0,
                buttonColor: primaryColor,
              ),
            ),
            showCancel ? const SizedBox(width: margin) : const SizedBox(),
            showCancel
                ? Expanded(
                    child: CustomSubmitButton(
                      onTap: () {
                        Get.back();

                        if (onCancel != null) {
                          onCancel!();
                        }
                      },
                      title: cancelText ?? 'cancel'.tr,
                      borderRadius: 10,
                      showBorder: true,
                      fontColor: Colors.grey,
                      buttonColor: Colors.transparent,
                      buttonHeight: 45.0,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
