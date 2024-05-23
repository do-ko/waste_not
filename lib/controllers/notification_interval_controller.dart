import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationsIntervalController extends GetxController {
  var notificationInterval = 1.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    notificationInterval.value = storage.read('notificationInterval') ?? 1;
  }

  void updateInterval(int interval) {
    notificationInterval.value = interval;
    storage.write('notificationInterval', interval);
  }
}