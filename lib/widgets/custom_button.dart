import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? buttonMargin;
  final double borderRadius;
  final String iconPath;
  final String title;

  const CustomButton({
    super.key,
    required this.onTap,
    this.buttonPadding,
    this.buttonMargin,
    this.borderRadius = 10.0,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: buttonMargin,
        padding:
            buttonPadding ??
            EdgeInsets.symmetric(horizontal: marginX2, vertical: marginX2),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 65.0,
              width: 65.0,
              child: SvgPicture.asset('assets/icons/$iconPath'),
            ),
            SizedBox(width: margin),
            TextFontStyle(title, size: 24.0, weight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
