import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';

class CustomBackButton extends StatefulWidget {
  final Function()? onTap;

  const CustomBackButton({
    super.key,
    this.onTap,
  });

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();

        if (widget.onTap != null) {
          widget.onTap;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: marginX2),
        child: Container(
          height: 40.0,
          width: 40.0,
          margin: const EdgeInsets.symmetric(vertical: 25.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_rounded,
              color: primaryColor,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}