import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto PME'),
        centerTitle: true,
      ),
      body: Column(
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
                        startValue: 0, endValue: 60, color: Colors.green),
                    GaugeRange(
                        startValue: 60, endValue: 120, color: Colors.orange),
                    GaugeRange(
                        startValue: 120, endValue: 180, color: Colors.red)
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: controller.speed(),
                      enableDragging: true,
                      onValueChanged: (newValue) {
                        controller.speed(newValue.round() * 1.0);
                        controller.speed.refresh();
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
