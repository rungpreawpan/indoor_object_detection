import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/controller/voice_controller.dart';
import 'package:indoor_object_detection/localization/localize.dart';
import 'package:indoor_object_detection/views/intro/controller/intro_controller.dart';
import 'package:indoor_object_detection/views/object_detection/object_detection_page.dart';
import 'package:indoor_object_detection/views/ocr/ocr_page.dart';
import 'package:indoor_object_detection/views/splash_page.dart';
import 'package:indoor_object_detection/widgets/custom_bottom_nav.dart';
import 'views/settings/controller/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AppInfoController());
  Get.put(SettingsController());
  Get.put(IntroController());

  // Get.put(VoiceController(), permanent: true); //TODO

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((value) => runApp(const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GuideStep',
      translations: Translation(),
      locale: const Locale('th'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('th'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.kanit().fontFamily,
        primaryColor: primaryColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
        ),
      ),
      // home: SplashPage(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage()),
        GetPage(name: '/CustomNavBar', page: () => CustomNavBar()),
        GetPage(name: '/ObjectDetectionPage', page: () => ObjectDetectionPage()),
        GetPage(name: '/OcrPage', page: () => OcrPage()),
      ],
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}