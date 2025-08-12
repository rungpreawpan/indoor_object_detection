import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/views/intro/intro_page.dart';
import 'package:indoor_object_detection/widgets/custom_bottom_nav.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppInfoController _appInfoController = Get.put(AppInfoController());

  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _checkFirstRun();
    _checkVersion();
    _settings();
    _redirect();
  }

  _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }
  }

  _checkVersion() {
    _appInfoController.getDeviceInfo();
  }

  _redirect() async {
    await _appInfoController.getDeviceInfo();
    await Future.delayed(const Duration(seconds: 2));

    // for dev only
    // await storage.delete(key: 'permission');

    String? permission = await storage.read(key: 'permission');

    if (permission == null) {
      Get.off(() => const IntroPage());
    } else {
      Get.off(() => const CustomNavBar());
    }
  }

  _settings() async {
    String? settingsValue = await storage.read(key: 'settings_value');

    if (settingsValue == null) {
      String settingsData = jsonEncode({
        'use_speech_recognition': true,
        'speed': 'normal',
        'language': Get.locale.toString() == 'th' ? 'thai' : 'english',
      });

      await storage.write(key: 'settings_value', value: settingsData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _logo(),
              ),
              _appVersion(),
            ],
          ),
        ),
      ),
    );
  }

  _logo() {
    return Image.asset('assets/logo/logo.png');
  }

  _appVersion() {
    return Obx(() {
      return TextFontStyle(
        'v ${_appInfoController.appVersion.value}',
        size: fontSizeM,
        weight: FontWeight.bold,
        color: primaryColor,
      );
    });
  }
}
