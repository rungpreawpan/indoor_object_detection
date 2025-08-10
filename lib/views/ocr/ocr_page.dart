import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/views/ocr/controller/ocr_controller.dart';
import 'package:indoor_object_detection/views/ocr/ocr_result_page.dart';
import 'package:indoor_object_detection/widgets/custom_camera_button.dart';
import 'package:indoor_object_detection/widgets/custom_gallery_button.dart';
import 'package:indoor_object_detection/widgets/custom_loading.dart';
import 'package:indoor_object_detection/widgets/custom_switch_camera_button.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:photo_manager/photo_manager.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  final OcrController _ocrController = Get.put(OcrController());

  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  int _selectedCameraIndex = 0;

  File? _imageFile;
  Uint8List? _thumbnailImage;

  @override
  void initState() {
    super.initState();

    _initializeCamera();
    _loadLatestImage();
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

  Future<void> _loadLatestImage() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth || permission == PermissionState.limited) {
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        final recentAlbum = albums.first;
        final recentAssets =
            await recentAlbum.getAssetListPaged(page: 0, size: 1);

        if (recentAssets.isNotEmpty) {
          final asset = recentAssets.first;
          final thumb =
              await asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
          _thumbnailImage = thumb;
          setState(() {});
        }
      }

      if (permission == PermissionState.limited) {
        await PhotoManager.presentLimited();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'scan text'.tr,
      showBackButton: true,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  _cameraController != null
                      ? CameraPreview(_cameraController!)
                      : const SizedBox(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: marginX2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomGalleryButton(
                            onTap: () async {
                              XFile? file = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );

                              if (file != null) {
                                await _ocrController
                                    .uploadImage(File(file.path));
                                Get.to(() =>
                                    OcrResultPage(imageFile: File(file.path)));
                              }
                            },
                            thumbnailImage: _thumbnailImage,
                          ),
                          CustomCameraButton(
                            onTap: () {
                              _scanText();
                              HapticFeedback.selectionClick();
                            },
                          ),
                          CustomSwitchCameraButton(
                            onTap: () {
                              if (_cameras == null || _cameras!.length < 2) {
                                return;
                              }

                              if (_selectedCameraIndex == 0) {
                                _selectedCameraIndex =
                                    (_selectedCameraIndex + 1) %
                                        _cameras!.length;
                              } else {
                                _selectedCameraIndex = 0;
                              }
                              _initializeCamera(_selectedCameraIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _loading(),
        ],
      ),
    );
  }

  _scanText() async {
    final XFile picture = await _cameraController!.takePicture();
    _imageFile = File(picture.path);

    if (_imageFile != null) {
      await _ocrController.uploadImage(_imageFile!);

      if (_ocrController.ocrText != null) {
        Get.to(() => OcrResultPage(imageFile: _imageFile!));
      }
    }
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _ocrController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
