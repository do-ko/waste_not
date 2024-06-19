import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../views/shared/theme.dart';

class DarkModeController extends GetxController {
  final deviceStorage = GetStorage();
  final RxBool _darkMode = false.obs;
  RxBool get darkMode => _darkMode;

  @override
  void onInit() {
    super.onInit();
    bool? darkModeStored = deviceStorage.read<bool>('darkMode');
    _darkMode.value = darkModeStored ?? false;
  }

  void setDarkMode(bool value) {
    _darkMode.value = value;
    Get.changeTheme(value ? darkTheme : lightTheme);
  }

  // void toggleDarkMode() {
  //   darkMode = !darkMode.value;
  // }

  void saveDarkModePreference() async {
    await deviceStorage.write('darkMode', _darkMode.value);
  }
}

class NotificationsController extends GetxController {
  final deviceStorage = GetStorage();
  final RxBool _notifications = false.obs;
  RxBool get notifications => _notifications;

  @override
  void onInit() {
    super.onInit();
    bool? notificationsStored = deviceStorage.read<bool>('notifications');
    _notifications.value = notificationsStored ?? false;
  }
}

class LanguageController extends GetxController {
  final deviceStorage = GetStorage();
  final RxList<String> _languages = <String>['English', 'Polish'].obs;
  final RxString _language = 'English'.obs;
  RxString get language => _language;
  List<String> get languages => _languages.toList();

  @override
  void onInit() {
    super.onInit();
    String? languageStored = deviceStorage.read<String>('language');
    _language.value = languageStored ?? 'English';
  }

  void updateLanguage(String newLanguage) {
    language.value = newLanguage;
  }
}

class NotificationsIntervalController extends GetxController {
  final deviceStorage = GetStorage();
  final RxInt _notificationInterval = 3.obs;
  RxInt get notificationInterval => _notificationInterval;

  @override
  void onInit() {
    super.onInit();
    int? notificationIntervalStored =
        deviceStorage.read<int>('notificationsInterval');
    _notificationInterval.value = notificationIntervalStored ?? 3;
  }

  void updateInterval(int newNotificationInterval) {
    notificationInterval.value = newNotificationInterval;
  }
}
