import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AppInfoController extends GetxController {
  var appVersion = ''.obs;
  var model = ''.obs;
  var os = ''.obs;
  var uuid = ''.obs;

  var cameraGranted = false.obs;
  var galleryGranted = false.obs;
  var micGranted = false.obs;
  var speechToTextGranted = false.obs;

  FlutterSecureStorage storage = const FlutterSecureStorage();

  getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion('$version ($buildNumber)');

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String osVersion =
          'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';

      const androidIdPlugin = AndroidId();
      final String? androidId = await androidIdPlugin.getId();

      model(androidInfo.model);
      uuid(androidId);
      os(osVersion);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      model(iosInfo.modelName);
      os('${iosInfo.systemName} ${iosInfo.systemVersion}');
      uuid(iosInfo.identifierForVendor);
    }

    await storage.write(key: 'uuid', value: uuid.value);
  }

  checkPermission() async {
    if (await Permission.camera.isGranted) {
      cameraGranted(true);
    } else {
      cameraGranted(false);
    }

    if (await Permission.microphone.isGranted) {
      micGranted(true);
    } else {
      micGranted(false);
    }

    bool useStoragePermission = false;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        useStoragePermission = true;
      }
    }

    if (useStoragePermission) {
      if (await Permission.storage.isGranted) {
        galleryGranted(true);
      } else {
        galleryGranted(false);
      }
    } else {
      if (await Permission.photos.isGranted) {
        galleryGranted(true);
      } else {
        galleryGranted(false);
      }
    }

    if (await Permission.speech.isGranted) {
      speechToTextGranted(true);
    } else {
      speechToTextGranted(false);
    }
  }
}