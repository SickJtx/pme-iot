import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/postionService.dart';

class HomeController extends GetxController {
  final RxDouble speed = 0.0.obs;

  void reset() async {
    speed(0);
    speed.refresh();
    bool respuesta = await PositionService().updatePosition(speed().toInt());

    if (respuesta) {
      Get.snackbar(
        'Aviso',
        'Posicion actualizada',
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'Aviso',
        'Posicion En espera de ser actualizada',
        backgroundColor: Colors.red,
      );
    }
  }

  void right() async {
    if (speed() >= 180) {
      return;
    }
    speed(speed() + 1);
    speed.refresh();
    bool respuesta = await PositionService().updatePosition(speed().toInt());

    if (respuesta) {
      Get.snackbar(
        'Aviso',
        'Posicion actualizada',
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'Aviso',
        'Posicion En espera de ser actualizada',
        backgroundColor: Colors.red,
      );
    }
  }

  void left() async {
    if (speed() <= 0) {
      return;
    }
    speed(speed() - 1);
    speed.refresh();
    bool respuesta = await PositionService().updatePosition(speed().toInt());

    if (respuesta) {
      Get.snackbar(
        'Aviso',
        'Posicion actualizada',
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        'Aviso',
        'Posicion En espera de ser actualizada',
        backgroundColor: Colors.red,
      );
    }
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
