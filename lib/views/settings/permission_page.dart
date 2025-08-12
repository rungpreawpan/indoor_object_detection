import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/views/settings/components/settings_label.dart';
import 'package:indoor_object_detection/widgets/custom_ok_cancel_dialog.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  final AppInfoController _appInfoController = Get.find();

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _appInfoController.checkPermission();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'permission'.tr,
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: marginX2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _camera(),
            const SizedBox(height: marginX2),
            _gallery(),
            const SizedBox(height: marginX2),
            _mic(),
            Platform.isAndroid
                ? SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: marginX2),
                      _stt(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _permission({
    required String title,
    required bool permission,
    required String description,
    required String imagePath,
    required Function() onOk,
  }) {
    return SettingsLabel(
      title: title,
      buttonInitialValue: permission ? 'allowed'.tr : 'denied'.tr,
      settingsLabelStyle: SettingsLabelStyle.interact,
      onTap: !permission
          ? () async {
              Get.dialog(
                CustomOkCancelDialog(
                  title: title,
                  titleSize: fontSizeXL,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 200.0,
                        child: SvgPicture.asset('assets/intro/$imagePath.svg'),
                      ),
                      const SizedBox(height: marginX2),
                      TextFontStyle(
                        description,
                        size: fontSizeL,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                  onOK: onOk,
                  okText: 'allowed'.tr,
                  showClosedButton: true,
                  showCancel: false,
                ),
                barrierDismissible: false,
              );
            }
          : () {},
    );
  }

  _camera() {
    return _permission(
      title: 'camera'.tr,
      permission: _appInfoController.cameraGranted.value,
      description: 'camera intro description'.tr,
      imagePath: 'camera',
      onOk: () async {
        var status = await Permission.camera.status;

        if (status.isGranted) {
          _appInfoController.cameraGranted(true);
        } else if (status.isDenied) {
          var result = await Permission.camera.request();
          if (result.isGranted) {
            _appInfoController.cameraGranted(true);
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      },
    );
  }

  _gallery() {
    return _permission(
      title: 'gallery'.tr,
      permission: _appInfoController.galleryGranted.value,
      description: 'gallery intro description'.tr,
      imagePath: 'gallery',
      onOk: () async {
        var status = await Permission.storage.status;

        if (status.isGranted) {
          _appInfoController.galleryGranted(true);
        } else if (status.isDenied) {
          var result = await Permission.storage.request();
          if (result.isGranted) {
            _appInfoController.galleryGranted(true);
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      },
    );
  }

  _mic() {
    return _permission(
      title: 'mic'.tr,
      permission: _appInfoController.micGranted.value,
      description: 'mic intro description'.tr,
      imagePath: 'microphone',
      onOk: () async {
        var status = await Permission.microphone.status;

        if (status.isGranted) {
          _appInfoController.micGranted(true);
        } else if (status.isDenied) {
          var result = await Permission.microphone.request();
          if (result.isGranted) {
            _appInfoController.micGranted(true);
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      },
    );
  }

  _stt() {
    return _permission(
      title: 'stt'.tr,
      permission: _appInfoController.speechToTextGranted.value,
      description: 'stt intro description'.tr,
      imagePath: 'speech',
      onOk: () async {
        var status = await Permission.speech.status;

        if (status.isGranted) {
          _appInfoController.speechToTextGranted(true);
        } else if (status.isDenied) {
          var result = await Permission.speech.request();
          if (result.isGranted) {
            _appInfoController.speechToTextGranted(true);
          }
        } else if (status.isPermanentlyDenied) {
          await openAppSettings();
        }
      },
    );
  }
}
