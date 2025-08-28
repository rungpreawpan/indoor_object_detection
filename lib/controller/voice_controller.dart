// import 'dart:developer';
//
// import 'package:get/get.dart';
// import 'package:indoor_object_detection/views/settings/controller/settings_controller.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// class VoiceController extends GetxController {
//   final SettingsController _settingsController = Get.find();
//
//   final _stt = SpeechToText();
//   final lastText = ''.obs;
//   bool _isCommandMode = false;
//
//   final wakeWordEN = 'hello';
//   final wakeWordTH = 'สวัสดี';
//
//   // final wakeWordTH = 'เฮ้ วิชั่น';
//
//   @override
//   void onInit() {
//     super.onInit();
//     initSTT();
//   }
//
//   Future<void> initSTT() async {
//     if (!_settingsController.useSpeechRecognition.value) {
//       log('Speech recognition is disabled in settings');
//       return;
//     }
//
//     final available = await _stt.initialize(
//       onStatus: (status) {
//         if ((status == 'done' || status == 'notListening') && !_isCommandMode) {
//         // if (!_isCommandMode) {
//           startListening();
//         }
//       },
//       onError: (error) {
//         Future.delayed(const Duration(seconds: 1), startListening);
//       },
//     );
//
//     if (available) {
//       startListening();
//     } else {
//       log('speech recognition not available on this device');
//     }
//   }
//
//   // void startListening() {
//   //   final locale = _settingsController.currentLocale.value;
//   //
//   //   _stt.listen(
//   //     localeId: _settingsController.localeToString(locale),
//   //     listenFor: const Duration(seconds: 10),
//   //     pauseFor: const Duration(seconds: 3),
//   //     onResult: (result) async {
//   //       final text = result.recognizedWords.toLowerCase();
//   //       lastText.value = text;
//   //       print('start: $text');
//   //
//   //       final isWakeWord =
//   //           (_settingsController.localeToString(locale) == 'th_TH' &&
//   //                   text.contains(wakeWordTH)) ||
//   //               (_settingsController.localeToString(locale) != 'th_TH' &&
//   //                   text.contains(wakeWordEN));
//   //
//   //       if (isWakeWord) {
//   //         await _stt.stop();
//   //         onWakeWordDetected(_settingsController.localeToString(locale));
//   //       }
//   //     },
//   //   );
//   // }
//   //
//   // void onWakeWordDetected(String locale) async {
//   //   log('Wake word detected ($locale)');
//   //
//   //   _stt.listen(
//   //     localeId: locale,
//   //     listenFor: const Duration(seconds: 5),
//   //     pauseFor: const Duration(seconds: 2),
//   //     onResult: (result) {
//   //       print('wake: $result');
//   //       final command = result.recognizedWords.toLowerCase();
//   //       handleCommand(command, locale);
//   //     },
//   //   );
//   // }
//
//   void startListening() {
//     final locale = _settingsController.currentLocale.value;
//
//     _isCommandMode = false;
//     _stt.listen(
//       localeId: _settingsController.localeToString(locale),
//       listenFor: const Duration(seconds: 10),
//       pauseFor: const Duration(seconds: 3),
//       onResult: (result) async {
//         if (_isCommandMode) return;
//
//         final text = result.recognizedWords.toLowerCase();
//         lastText.value = text;
//         print('start: $text');
//
//         final isWakeWord =
//             (_settingsController.localeToString(locale) == 'th_TH' &&
//                     text.contains(wakeWordTH)) ||
//                 (_settingsController.localeToString(locale) != 'th_TH' &&
//                     text.contains(wakeWordEN));
//
//         if (isWakeWord) {
//           _isCommandMode = true;
//           await _stt.stop();
//           onWakeWordDetected(_settingsController.localeToString(locale));
//         }
//       },
//     );
//   }
//
//   void onWakeWordDetected(String locale) async {
//     log('Wake word detected ($locale)');
//
//     if (_stt.isListening) {
//       await _stt.stop();
//     }
//
//     _stt.listen(
//       localeId: locale,
//       listenFor: const Duration(seconds: 5),
//       pauseFor: const Duration(seconds: 2),
//       onResult: (result) async {
//         print('wake: $result');
//         final command = result.recognizedWords.toLowerCase();
//         await _stt.stop();
//         handleCommand(command, locale);
//
//         Future.delayed(Duration(milliseconds: 300), () {
//           startListening();
//         });
//       },
//     );
//   }
//
//   void handleCommand(String command, String locale) {
//     log('Command received: $command');
//
//     if (locale == 'th_TH') {
//       if (command.contains('หน้าหลัก')) {
//         Get.offAllNamed('/');
//       } else if (command.contains('ตรวจจับวัตถุ')) {
//         Get.toNamed('/ObjectDetectionPage');
//       } else if (command.contains('สแกนตัวหนังสือ')) {
//         Get.toNamed('/OcrPage');
//       } else {
//         searchTextInApp(command);
//       }
//     } else {
//       if (command.contains('home')) {
//         Get.offAllNamed('/');
//       } else if (command.contains('object detection') ||
//           command.contains('object detection')) {
//         Get.toNamed('/ObjectDetectionPage');
//       } else if (command.contains('scan text') || command.contains('ocr')) {
//         Get.toNamed('/OcrPage');
//       } else {
//         searchTextInApp(command);
//       }
//     }
//   }
//
//   void searchTextInApp(String text) {
//     // ตรงนี้คุณสามารถทำเป็นฟังก์ชันค้นหาข้อความในแอป หรือเรียก event อะไรก็ได้
//     log('Search in app for: $text');
//   }
// }



import 'dart:developer';

import 'package:get/get.dart';
import 'package:indoor_object_detection/views/settings/controller/settings_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceController extends GetxController {
  final SettingsController _settingsController = Get.find();

  final _stt = SpeechToText();
  final lastText = ''.obs;
  bool _isCommandMode = false;
  bool _isListening = false;

  final wakeWordEN = 'hello';
  final wakeWordTH = 'สวัสดี';

  @override
  void onInit() {
    super.onInit();
    initSTT();
  }

  Future<void> initSTT() async {
    if (!_settingsController.useSpeechRecognition.value) {
      log('Speech recognition is disabled in settings');
      return;
    }

    final available = await _stt.initialize(
      onStatus: (status) {
        log('STT Status: $status');

        // รีเซ็ต state เมื่อ STT หยุดทำงาน
        if (status == 'notListening' || status == 'done') {
          _isListening = false;
        } else if (status == 'listening') {
          _isListening = true;
        }

        // เริ่มฟังใหม่เมื่อ STT เสร็จสิ้น
        if ((status == 'done' || status == 'notListening') && !_isCommandMode) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!_isCommandMode && !_isListening) {
              startListening();
            }
          });
        }
      },
      onError: (error) {
        log('STT Error: $error');
        _isListening = false;
        _isCommandMode = false;

        // สำหรับ permanent error ให้รอนานขึ้น
        final delay = error.permanent ? 3 : 1;
        log('Error is ${error.permanent ? "permanent" : "temporary"}, waiting ${delay}s before retry');

        Future.delayed(Duration(seconds: delay), () {
          if (!_isCommandMode && !_isListening) {
            log('Retrying STT initialization...');
            initSTT(); // รีเริ่ม STT ใหม่เมื่อเกิด permanent error
          }
        });
      },
    );

    if (available) {
      log('STT initialized successfully');
      await Future.delayed(const Duration(milliseconds: 300));
      startListening();
    } else {
      log('Speech recognition not available on this device');
    }
  }

  Future<void> startListening() async {
    // ตรวจสอบ state ทั้งหมด
    // if (_isCommandMode) {
    //   log('⏸️ Skipping startListening - In command mode');
    //   return;
    // }
    //
    // if (_isListening) {
    //   log('⏸️ Already listening, skipping...');
    //   return;
    // }
    //
    // if (_stt.isListening) {
    //   log('⏸️ STT is already listening, skipping...');
    //   return;
    // }

    final locale = _settingsController.currentLocale.value;
    final localeString = _settingsController.localeToString(locale);

    log('🎤 Starting to listen for wake word (locale: $localeString)...');

    try {
      _stt.listen(
        localeId: localeString,
        listenFor: const Duration(seconds: 15), // เพิ่มเวลาฟัง
        pauseFor: const Duration(seconds: 2),   // ลดเวลา pause
        onResult: (result) async {
          if (_isCommandMode) {
            log('Command mode active, ignoring wake word detection');
            return;
          }

          final text = result.recognizedWords.toLowerCase();
          lastText.value = text;

          // แสดง log เฉพาะเมื่อมีข้อความ
          if (text.isNotEmpty) {
            log('👂 Wake word listening: "$text"');

            final isWakeWord = (localeString == 'th_TH' && text.contains(wakeWordTH)) ||
                (localeString != 'th_TH' && text.contains(wakeWordEN));

            if (isWakeWord) {
              log('✅ Wake word detected! Text: "$text", Locale: $localeString');
              _isCommandMode = true;
              _isListening = false;

              // หยุด STT ปัจจุบัน
              if (_stt.isListening) {
                await _stt.stop();
              }

              // รอให้ STT หยุดสมบูรณ์
              await Future.delayed(const Duration(milliseconds: 500));

              onWakeWordDetected(localeString);
            }
          }
        },
      );
    } catch (e) {
      log('❌ Error in startListening: $e');
      _isListening = false;
      _isCommandMode = false;

      // รีเริ่มหลังจาก error
      Future.delayed(const Duration(seconds: 2), () {
        if (!_isCommandMode && !_isListening) {
          startListening();
        }
      });
    }
  }

  Future<void> onWakeWordDetected(String locale) async {
    log('🎯 Wake word detected - Starting command listening ($locale)');

    // ตรวจสอบและหยุด STT หาก listening อยู่
    if (_stt.isListening) {
      log('Stopping current STT session...');
      await _stt.stop();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    try {
      log('🎙️ Listening for command...');
      _stt.listen(
        localeId: locale,
        listenFor: const Duration(seconds: 7),  // เพิ่มเวลาฟัง command
        pauseFor: const Duration(seconds: 1),   // ลดเวลา pause
        onResult: (result) async {
          final command = result.recognizedWords.toLowerCase();
          log('🗣️ Command received: "$command"');

          // หยุด STT ทันทีเมื่อได้รับ command
          if (_stt.isListening) {
            await _stt.stop();
          }

          // ประมวลผล command
          if (command.isNotEmpty) {
            handleCommand(command, locale);
          } else {
            log('⚠️ Empty command received');
          }

          // รีเซ็ต state และกลับไปฟัง wake word
          _isCommandMode = false;
          _isListening = false;

          // รอสักครู่ก่อนเริ่มฟัง wake word ใหม่
          log('🔄 Returning to wake word detection in 1 second...');
          Future.delayed(const Duration(seconds: 1), () {
            if (!_isCommandMode && !_isListening) {
              startListening();
            }
          });
        },
      );
    } catch (e) {
      log('❌ Error in onWakeWordDetected: $e');
      // หากเกิดข้อผิดพลาด รีเซ็ต state และกลับไปฟัง wake word
      _isCommandMode = false;
      _isListening = false;
      Future.delayed(const Duration(seconds: 1), () {
        if (!_isCommandMode && !_isListening) {
          startListening();
        }
      });
    }
  }

  void handleCommand(String command, String locale) {
    log('🎯 Processing command: "$command" (locale: $locale)');

    if (locale == 'th_TH') {
      if (command.contains('หน้าหลัก')) {
        log('Navigating to home page');
        Get.offAllNamed('/');
      } else if (command.contains('ตรวจจับวัตถุ')) {
        log('Navigating to object detection page');
        Get.toNamed('/ObjectDetectionPage');
      } else if (command.contains('สแกนตัวหนังสือ')) {
        log('Navigating to OCR page');
        Get.toNamed('/OcrPage');
      } else {
        log('No matching command, performing search');
        searchTextInApp(command);
      }
    } else {
      if (command.contains('home')) {
        log('Navigating to home page');
        Get.offAllNamed('/');
      } else if (command.contains('object detection')) {
        log('Navigating to object detection page');
        Get.toNamed('/ObjectDetectionPage');
      } else if (command.contains('scan text') || command.contains('ocr')) {
        log('Navigating to OCR page');
        Get.toNamed('/OcrPage');
      } else {
        log('No matching command, performing search');
        searchTextInApp(command);
      }
    }
  }

  void searchTextInApp(String text) {
    log('Search in app for: $text');
  }

  // ฟังก์ชันทดสอบ wake word detection
  void testWakeWordDetection(String text) {
    final locale = _settingsController.currentLocale.value;
    final localeString = _settingsController.localeToString(locale);

    log('🧪 Testing wake word detection:');
    log('  Input text: "$text"');
    log('  Current locale: $localeString');
    log('  Wake word EN: "$wakeWordEN"');
    log('  Wake word TH: "$wakeWordTH"');

    final isWakeWordTH = localeString == 'th_TH' && text.toLowerCase().contains(wakeWordTH);
    final isWakeWordEN = localeString != 'th_TH' && text.toLowerCase().contains(wakeWordEN);

    log('  Contains TH wake word: $isWakeWordTH');
    log('  Contains EN wake word: $isWakeWordEN');
    log('  Final result: ${isWakeWordTH || isWakeWordEN}');
  }

  @override
  void onClose() {
    if (_stt.isListening) {
      _stt.stop();
    }
    super.onClose();
  }

  // ฟังก์ชันสำหรับรีสตาร์ท STT เมื่อเกิดปัญหา
  Future<void> restartSTT() async {
    log('🔄 Restarting STT system...');

    // รีเซ็ต state ทั้งหมด
    _isCommandMode = false;
    _isListening = false;

    // หยุด STT ปัจจุบัน
    if (_stt.isListening) {
      await _stt.stop();
    }

    // รอสักครู่แล้วเริ่มใหม่
    await Future.delayed(const Duration(milliseconds: 500));
    await initSTT();
  }

  // ฟังก์ชันตรวจสอบสถานะ STT
  String getSTTStatus() {
    return '''
STT Status:
- isListening: ${_stt.isListening}
- _isCommandMode: $_isCommandMode  
- _isListening: $_isListening
- lastText: ${lastText.value}
- Available: ${_stt.isAvailable}
''';
  }
}