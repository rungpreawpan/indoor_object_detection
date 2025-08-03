import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:indoor_object_detection/service/request_service.dart';
import 'package:indoor_object_detection/views/ocr/ocr_model.dart';
import 'package:indoor_object_detection/views/ocr/ocr_state.dart';

class OcrController extends StateNotifier<OcrState> {
  OcrController() : super(const OcrState());

  Future<void> uploadImage(File image) async {
    bool isOnline = await RequestService().checkInternetConnection();
    if (!isOnline) {
      //TODO
      // showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);

      final reqData = {
        "image":
        MultipartFile.fromFileSync(image.path, filename: 'object_image'),
        "lang": 'tha+eng',
      };

      final formData = FormData.fromMap(reqData);

      final response = await RequestService().request(
        '/upload-ocr',
        method: HttpMethod.post,
        data: formData,
      );

      if (response != null && response.statusCode == 200) {
        await ocrResults();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> ocrResults() async {
    bool isOnline = await RequestService().checkInternetConnection();
    if (!isOnline) {
      // showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);

      final response = await RequestService().request(
        '/ocr-result',
        method: HttpMethod.get,
      );

      if (response != null && response.statusCode == 200) {
        final dataMap = response.data as Map<String, dynamic>;
        final ocrModel = OcrModel.fromJSON(dataMap);
        state = state.copyWith(ocrText: ocrModel);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}