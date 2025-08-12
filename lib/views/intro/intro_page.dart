import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/views/intro/controller/intro_controller.dart';
import 'package:indoor_object_detection/views/intro/template/intro_template.dart';
import 'package:indoor_object_detection/widgets/custom_bottom_nav.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final AppInfoController _appInfoController = Get.find();
  final IntroController _introController = Get.find();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  _content() {
    return Obx(() {
      switch (_introController.currentPage.value) {
        case 0:
          return IntroTemplate(
            isWelcomePage: true,
            iconPath: '',
            description: 'welcome to guidestep'.tr,
            next: _welcome,
            back: () {},
          );

        case 1:
          return IntroTemplate(
            iconPath: 'assets/intro/camera.svg',
            description: 'camera intro description'.tr,
            next: _cameraPermission,
            back: () {
              _introController.currentPage(0);
            },
          );

        case 2:
          return IntroTemplate(
            iconPath: 'assets/intro/gallery.svg',
            description: 'gallery intro description'.tr,
            next: _galleryPermission,
            back: () {
              _introController.currentPage(1);
            },
          );

        case 3:
          return IntroTemplate(
            iconPath: 'assets/intro/microphone.svg',
            description: 'mic intro description'.tr,
            next: _micPermission,
            // next: Platform.isAndroid
            //     ? () {
            //         _introController.currentPage(5);
            //       }
            //     : _micPermission,
            back: () {
              _introController.currentPage(2);
            },
          );

        case 4:
          return IntroTemplate(
            iconPath: 'assets/intro/speech.svg',
            description: 'stt intro description'.tr,
            next: _speechToTextPermission,
            back: () {
              _introController.currentPage(3);
            },
          );

        case 5:
          return const CustomNavBar();

        default:
          return Container();
      }
    });
  }

  _welcome() async {
    _introController.currentPage(1);
  }

  _cameraPermission() async {
    var result = await Permission.camera.request();

    if (result == PermissionStatus.granted) {
      _appInfoController.cameraGranted(true);
    } else {
      _appInfoController.cameraGranted(false);
    }

    _introController.currentPage(2);
  }

  _galleryPermission() async {
    bool useStoragePermission = false;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        useStoragePermission = true;
        await Permission.storage.request();
      }
    }

    await Permission.photos.request();

    PermissionStatus result;
    if (useStoragePermission) {
      result = await Permission.storage.status;
    } else {
      result = await Permission.photos.status;
    }

    if (result == PermissionStatus.granted) {
      _appInfoController.galleryGranted(true);
    } else {
      _appInfoController.galleryGranted(false);
    }

    _introController.currentPage(3);
  }

  _micPermission() async {
    var result = await Permission.microphone.request();

    if (result == PermissionStatus.granted) {
      _appInfoController.micGranted(true);
    } else {
      _appInfoController.micGranted(false);
    }

    if (Platform.isAndroid) {
      _introController.currentPage(5);
      await storage.write(key: 'permission', value: 'true');
      return;
    }

    _introController.currentPage(4);
  }

  _speechToTextPermission() async {
    var result = await Permission.speech.request();

    if (result == PermissionStatus.granted) {
      _appInfoController.speechToTextGranted(true);
    } else {
      _appInfoController.speechToTextGranted(false);
    }

    _introController.currentPage(5);
    await storage.write(key: 'permission', value: 'true');
  }
}
