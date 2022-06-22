import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../controllers/home_controller.dart';
import '../../../../services/postionService.dart';

class HomeView extends GetView<HomeController> {
  void getPosition() async {}

  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance
        .ref('position')
        .onValue
        .listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      controller.speed(double.tryParse(data.toString()));

      print('data');
      print(data);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto PME'),
        centerTitle: true,
      ),
      body: Column(
        //future: PositionService().listenPosition(),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Obx(
            () => SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 180,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 60,
                        color: Color.fromARGB(255, 60, 92, 135)),
                    GaugeRange(
                        startValue: 60,
                        endValue: 120,
                        color: Color.fromARGB(255, 60, 92, 135)),
                    GaugeRange(
                        startValue: 120,
                        endValue: 180,
                        color: Color.fromARGB(255, 60, 92, 135))
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: controller.speed(),
                      enableDragging: true,
                      onValueChanged: (newValue) async {
                        controller.speed(newValue.round().abs() * 1);
                        controller.speed.refresh();
                        bool respuesta = await PositionService()
                            .updatePosition(newValue.round().abs());
                      },
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '${controller.speed().round()}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      angle: controller.speed(),
                      positionFactor: 0.5,
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: controller.left,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Text("Left"),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: controller.right,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  child: Text("Right"),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: controller.reset,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: Text("Reset"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
            child: Image.asset("assets/udep.png"),
          ),
        ],
      ),
    );
  }
}
