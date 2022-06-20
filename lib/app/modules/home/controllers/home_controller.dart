import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxDouble speed = 0.0.obs;

  void reset() {
    speed(0);
    speed.refresh();
  }

  void right() {
    if (speed() >= 180) {
      return;
    }
    speed(speed() + 1);
    speed.refresh();
  }

  void left() {
    if (speed() <= 0) {
      return;
    }
    speed(speed() - 1);
    speed.refresh();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
