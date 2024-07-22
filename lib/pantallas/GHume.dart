import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GHume extends StatelessWidget {
  const GHume({super.key, required this.humidity});
  final double humidity;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: const GaugeTitle(text: 'Humedad'),
        axes: <RadialAxis>[
          RadialAxis(
            labelsPosition: ElementsPosition.outside,
            axisLineStyle: const AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.1,
            ),
            majorTickStyle: const MajorTickStyle(
                length: 0.1, thickness: 2, lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: const MinorTickStyle(
                length: 0.05, thickness: 1.5, lengthUnit: GaugeSizeUnit.factor),
            minimum: 0,
            maximum: 100,
            interval: 10,
            showLastLabel: true,
            useRangeColorForAxis: true,
            axisLabelStyle: const GaugeTextStyle(fontWeight: FontWeight.bold),
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 33,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.red,
                  endWidth: 0.03,
                  startWidth: 0.03),
              GaugeRange(
                  startValue: 33,
                  endValue: 66,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.amber,
                  endWidth: 0.03,
                  startWidth: 0.03),
              GaugeRange(
                  startValue: 66,
                  endValue: 100,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: Colors.blue,
                  endWidth: 0.03,
                  startWidth: 0.03),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                  //Change with firebase data
                  value: humidity,
                  enableAnimation: true,
                  needleColor: Colors.black,
                  tailStyle: const TailStyle(
                      length: 0.18,
                      width: 8,
                      color: Colors.black,
                      lengthUnit: GaugeSizeUnit.factor),
                  needleLength: 0.68,
                  needleStartWidth: 1,
                  needleEndWidth: 8,
                  knobStyle: const KnobStyle(
                      knobRadius: 0.07,
                      color: Colors.white,
                      borderWidth: 0.05,
                      borderColor: Colors.black),
                  lengthUnit: GaugeSizeUnit.factor)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Text(
                    //Change with firebase data
                    '$humidity %',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  positionFactor: 0.8,
                  angle: 90)
            ],
          ),
        ]);
  }
}
