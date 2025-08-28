import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/tts_manager.dart';
import 'package:indoor_object_detection/views/obstacle/controller/obstacle_controller.dart';
import 'package:indoor_object_detection/views/settings/controller/settings_controller.dart';
import 'package:indoor_object_detection/views/settings/model/settings_model.dart';
import 'package:indoor_object_detection/widgets/custom_camera_button.dart';
import 'package:indoor_object_detection/widgets/custom_loading.dart';
import 'package:indoor_object_detection/widgets/custom_switch_camera_button.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:image/image.dart' as img;
import 'package:indoor_object_detection/widgets/text_font_style.dart';
import 'package:translator/translator.dart';

class ObstacleDetectionPage extends StatefulWidget {
  const ObstacleDetectionPage({super.key});

  @override
  State<ObstacleDetectionPage> createState() => _ObstacleDetectionPageState();
}

class _ObstacleDetectionPageState extends State<ObstacleDetectionPage> {
  final ObstacleController _obstacleController = Get.put(ObstacleController());
  final SettingsController _settingsController = Get.find();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final ttsManager = TtsManager();
  final translator = GoogleTranslator();

  SettingsModel? settingsInfo;

  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  int _selectedCameraIndex = 0;

  Timer? _autoCaptureTimer;
  bool _isCapturing = false;

  String? translatedText;

  @override
  void initState() {
    super.initState();

    _initializeCamera();
  }

  Future<void> _initializeCamera([int cameraIndex = 0]) async {
    try {
      _cameras = await availableCameras();

      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![cameraIndex],
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );

        await _cameraController!.initialize();

        if (!mounted) return;

        setState(() {});
      } else {
        log('No cameras available');
      }
    } catch (e) {
      log('Error initializing camera: $e');
    }
  }

  // Future _speak() async {
  //   if (_objectDetectionController.objectDetected?.boxes != null) {
  //     List<String> objects = [];
  //     translatedText = null;
  //
  //     for (BoxesModel object
  //     in _objectDetectionController.objectDetected!.boxes!) {
  //       if (object.label != null) {
  //         objects.add(object.label!);
  //       }
  //     }
  //
  //     if (objects.isNotEmpty) {
  //       List translations = await Future.wait(
  //         objects.map((obj) async {
  //           Translation? translation;
  //
  //           if (_settingsController.currentLocale.value.languageCode == 'th') {
  //             translation = await translator.translate(obj, to: 'th');
  //           } else {
  //             translation = await translator.translate(obj, to: 'en');
  //           }
  //
  //           return translation.text;
  //         }),
  //       );
  //
  //       translatedText = translations.toSet().toList().join(', ');
  //       await ttsManager.speak('${'detected'.tr} $translatedText');
  //       HapticFeedback.heavyImpact();
  //     } else {
  //       await ttsManager.speak('unable to detect objects'.tr);
  //     }
  //   }
  // }

  @override
  void dispose() {
    super.dispose();

    ttsManager.stop();
    _cameraController?.dispose();

    _autoCaptureTimer?.cancel();
    _autoCaptureTimer = null;
  }

  bool get _isFrontCamera =>
      _cameras != null &&
      _cameras!.isNotEmpty &&
      _cameras![_selectedCameraIndex].lensDirection ==
          CameraLensDirection.front;

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'obstacle detection'.tr,
      showBackButton: true,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Stack(
                children: [
                  _cameraController != null
                      ? _isFrontCamera
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: CameraPreview(_cameraController!),
                            )
                          : CameraPreview(_cameraController!)
                      : const SizedBox(),
                  _loading(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: marginX2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50.0,
                        height: 50.0,
                      ),
                      _cameraButton(),
                      _switchCamera(),
                    ],
                  ),
                ),
              ),
              translatedText != null
                  ?
              Align(
                      alignment: Alignment.topCenter,
                      child: _resultBox(
                        result: translatedText,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _startAutoCapture() async {
    await ttsManager.speak('start object detection'.tr);
    _isCapturing = true;

    _autoCaptureTimer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        XFile file = await _cameraController!.takePicture();

        // TODO:
        // await _objectDetectionController.uploadObject(File(file.path));
        // await _speak();

        setState(() {});
      },
    );
  }

  void _stopAutoCapture() async {
    _autoCaptureTimer?.cancel();
    ttsManager.stop();
    _autoCaptureTimer = null;
    _isCapturing = false;
    translatedText = null;
    setState(() {});

    await ttsManager.speak('stop object detection'.tr);
  }

  _cameraButton() {
    return CustomCameraButton(
      onTap: () async {
        if (_isCapturing) {
          _isCapturing = false;
          _stopAutoCapture();
        } else {
          _isCapturing = true;
          _startAutoCapture();
        }

        HapticFeedback.selectionClick();
        setState(() {});
      },
      icon: _isCapturing
          ? const Icon(
              Icons.stop_rounded,
              size: 28.0,
              color: Colors.black,
            )
          : null,
    );
  }

  _switchCamera() {
    return CustomSwitchCameraButton(
      onTap: () {
        if (_cameras == null || _cameras!.length < 2) {
          return;
        }

        if (_selectedCameraIndex == 0) {
          _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
        } else {
          _selectedCameraIndex = 0;
        }
        _initializeCamera(_selectedCameraIndex);
      },
    );
  }

  _resultBox({
    required String? result,
  }) {
    return Visibility(
      visible: result != null,
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.all(marginX2),
        padding: const EdgeInsets.symmetric(
          horizontal: marginX2,
          vertical: margin,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFontStyle(
          result!,
          size: fontSizeXL,
          align: TextAlign.center,
        ),
      ),
    );
  }

  Future<Size?> getImageSize(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return null;

    return Size(image.width.toDouble(), image.height.toDouble());
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _obstacleController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
