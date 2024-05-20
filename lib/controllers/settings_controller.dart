import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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