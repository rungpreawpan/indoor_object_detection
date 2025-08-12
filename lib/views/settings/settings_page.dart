import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:indoor_object_detection/constant/value_constant.dart';
import 'package:indoor_object_detection/controller/app_info_controller.dart';
import 'package:indoor_object_detection/views/settings/components/settings_label.dart';
import 'package:indoor_object_detection/views/settings/contact_dev_page.dart';
import 'package:indoor_object_detection/views/settings/controller/settings_controller.dart';
import 'package:indoor_object_detection/views/settings/model/settings_model.dart';
import 'package:indoor_object_detection/views/settings/permission_page.dart';
import 'package:indoor_object_detection/widgets/custom_item_picker.dart';
import 'package:indoor_object_detection/widgets/custom_item_picker_cell.dart';
import 'package:indoor_object_detection/widgets/custom_loading.dart';
import 'package:indoor_object_detection/widgets/main_template.dart';
import 'package:indoor_object_detection/widgets/text_font_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppInfoController _appInfoController = Get.find();
  final SettingsController _settingsController = Get.find();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  List<String> get speedList => ['slow'.tr, 'normal'.tr, 'fast'.tr];

  List<String> get languageList => ['thai'.tr, 'english'.tr];

  bool useSpeechRecognition = false;
  List<String> selectedSpeed = [];
  List<String> selectedLanguage = [];
  List<String> selectedTheme = [];

  SettingsModel? settingsInfo;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    String? settingsData = await storage.read(key: 'settings_value');

    if (settingsData != null) {
      Map<String, dynamic> settingsValueMap = json.decode(settingsData);
      settingsInfo = SettingsModel.fromJSON(settingsValueMap);
      _setUseSpeechRecognition();
      _setSpeedValue();
      _setLanguageValue();
    }

    setState(() {});
  }

  _setUseSpeechRecognition() {
    useSpeechRecognition = _settingsController.useSpeechRecognition.value;
  }

  _setSpeedValue() {
    selectedSpeed.clear();

    if (settingsInfo?.speed == 'slow') {
      selectedSpeed.add('slow'.tr);
    } else if (settingsInfo?.speed == 'normal') {
      selectedSpeed.add('normal'.tr);
    } else if (settingsInfo?.speed == 'fast') {
      selectedSpeed.add('fast'.tr);
    } else {
      selectedSpeed.add('normal'.tr);
    }
  }

  _setLanguageValue() {
    selectedLanguage.clear();

    if (settingsInfo?.language == 'thai') {
      selectedLanguage.add('thai'.tr);
    } else if (settingsInfo?.language == 'english') {
      selectedLanguage.add('english'.tr);
    } else {
      selectedLanguage.add('thai'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'settings'.tr,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _content(),
                ],
              ),
            ),
          ),
          _loading(),
        ],
      ),
    );
  }

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sound(),
        _divider(),
        _userInterface(),
        _divider(),
        _aboutApplication(),
      ],
    );
  }

  _sound() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFontStyle(
            'sound'.tr,
            size: fontSizeXL,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'voice control'.tr,
            settingsLabelStyle: SettingsLabelStyle.onOff,
            switchValue: useSpeechRecognition,
            onChanged: (value) async {
              useSpeechRecognition = !useSpeechRecognition;
              _settingsController.useSpeechRecognition.value =
                  useSpeechRecognition;

              _settingsController.setUseSpeechRecognition(
                  _settingsController.useSpeechRecognition.value);

              setState(() {});
            },
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'speech speed'.tr,
            buttonInitialValue:
                selectedSpeed.isNotEmpty ? selectedSpeed.first : 'normal'.tr,
            settingsLabelStyle: SettingsLabelStyle.interact,
            onTap: () async {
              List? result = await Get.to(
                () => CustomItemPicker(
                  title: 'speech speed'.tr,
                  items: speedList,
                  selectedItems: selectedSpeed,
                  showSearchBar: false,
                  pickMultipleItem: false,
                  onSearch: (String searchText) {},
                  itemWidget: (item, isSelected) {
                    return CustomItemPickerCell(
                      title: item,
                      isSelected: isSelected,
                    );
                  },
                ),
              );

              if (result != null) {
                String speed;
                if (selectedSpeed.first == 'slow'.tr) {
                  speed = 'slow';
                } else if (selectedSpeed.first == 'fast'.tr) {
                  speed = 'fast';
                } else {
                  speed = 'normal';
                }

                _settingsController.setSpeechSpeed(speed);

                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  _userInterface() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFontStyle(
            'user interface'.tr,
            size: fontSizeXL,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'language'.tr,
            buttonInitialValue: selectedLanguage.isNotEmpty
                ? selectedLanguage.first
                : 'thai'.tr,
            settingsLabelStyle: SettingsLabelStyle.interact,
            onTap: () async {
              List? result = await Get.to(
                () => CustomItemPicker(
                  title: 'language'.tr,
                  items: languageList,
                  selectedItems: selectedLanguage,
                  showSearchBar: false,
                  pickMultipleItem: false,
                  onSearch: (String searchText) {},
                  itemWidget: (item, isSelected) {
                    return CustomItemPickerCell(
                      title: item,
                      isSelected: isSelected,
                    );
                  },
                ),
              );

              if (result != null) {
                Locale locale;

                if (selectedLanguage.first == 'thai'.tr) {
                  locale = _settingsController.languageNameToLocale('thai');
                } else {
                  locale = _settingsController.languageNameToLocale('english');
                }

                _settingsController.setLanguage(locale);
                await _prepareData();

                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  _aboutApplication() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFontStyle(
            'about application'.tr,
            size: fontSizeXL,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'permission'.tr,
            settingsLabelStyle: SettingsLabelStyle.interact,
            onTap: () {
              Get.to(() => const PermissionPage());
            },
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'contact developer'.tr,
            settingsLabelStyle: SettingsLabelStyle.interact,
            onTap: () {
              Get.to(() => const ContactDevPage());
            },
          ),
          const SizedBox(height: marginX2),
          SettingsLabel(
            title: 'application version'.tr,
            buttonInitialValue: _appInfoController.appVersion.value,
            settingsLabelStyle: SettingsLabelStyle.showData,
          ),
        ],
      ),
    );
  }

  _divider() {
    return Divider(
      color: Colors.grey.shade300,
      indent: marginX2,
      endIndent: marginX2,
      thickness: 1.0,
      height: 50.0,
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _settingsController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
