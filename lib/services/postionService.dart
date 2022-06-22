import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hemiplejia_pme/app/modules/home/views/home_view.dart';
import '../app/modules/home/controllers/home_controller.dart';

class PositionService {
  Future<bool> updatePosition(int? position) async {
    try {
      await FirebaseDatabase.instance.ref('position').set(position);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> listenPosition() async {
    try {
      await FirebaseDatabase.instance
          .ref('position')
          .onValue
          .listen((DatabaseEvent event) {
        final data = event.snapshot.value;

        print('data');
        print(data);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
