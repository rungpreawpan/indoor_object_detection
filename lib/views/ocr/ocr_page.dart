import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/views/ocr/ocr_provider.dart';
import 'package:indoor_object_detection/widgets/custom_camera_button.dart';
import 'package:indoor_object_detection/widgets/custom_gallery_button.dart';
import 'package:indoor_object_detection/widgets/custom_loading.dart';
import 'package:indoor_object_detection/widgets/custom_switch_camera_button.dart';
import 'package:photo_manager/photo_manager.dart';

class OcrPage extends ConsumerStatefulWidget {
  const OcrPage({super.key});

  @override
  ConsumerState<OcrPage> createState() => _ScanTextPageState();
}

class _ScanTextPageState extends ConsumerState<OcrPage> {
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
    final ocrController = ref.read(ocrProvider.notifier);

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
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
                                  await ocrController.uploadImage(File(file.path));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => ScanTextResultPage(imageFile: File(file.path)),
                                  //   ),
                                  // );
                                }
                              },
                              thumbnailImage: _thumbnailImage,
                            ),
                            CustomCameraButton(onTap: _scanText),
                            CustomSwitchCameraButton(onTap: _switchCamera),
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
      ),
    );
  }

  Future<void> _scanText() async {
    final ocrController = ref.read(ocrProvider.notifier);
    final XFile picture = await _cameraController!.takePicture();
    _imageFile = File(picture.path);

    await ocrController.uploadImage(_imageFile!);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => ScanTextResultPage(imageFile: _imageFile!),
    //   ),
    // );
  }

  Widget _loading() {
    final isLoading = ref.watch(ocrProvider).isLoading;

    return Visibility(
      visible: isLoading,
      child: const CustomLoading(),
    );
  }

  void _switchCamera() {
    if (_cameras == null || _cameras!.length < 2) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    _initializeCamera(_selectedCameraIndex);
  }
}
