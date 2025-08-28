import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:indoor_object_detection/service/request_service.dart';
import 'package:indoor_object_detection/utils/alert.dart';
import 'package:indoor_object_detection/views/obstacle/model/obstacle_model.dart';

class ObstacleController extends GetxController {
  var isLoading = false.obs;

  ObstacleModel? obstacleDetected;

  uploadObstacle(File obstacle) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var reqData = {
        "image": MultipartFile.fromFileSync(obstacle.path,
            filename: 'obstacle_image'),
      };

      FormData formData = FormData.fromMap(reqData);

      var response = await RequestService().request(
        '/upload-obstacle',
        method: HttpMethod.post,
        data: formData,
      );

      if (response != null && response.statusCode == 200) {
        await getObstacle();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getObstacle() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/obstacle-results',
        method: HttpMethod.get,
      );

      if (response != null && response.statusCode == 200) {
        Map<String, dynamic> dataMap = response.data;
        Map<String, dynamic> dataJSON = dataMap['obstacles'];
        log(dataJSON.toString());

        obstacleDetected = ObstacleModel.fromJSON(dataJSON);

        // Map<String, dynamic> dataMap = response.data;
        // var dataJSON = dataMap['obstacle'];
        // log(dataJSON.toString());
        //
        // obstacleList = dataJSON
        //     .map<ObstacleModel>((json) => ObstacleModel.fromJSON(json))
        //     .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}