import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_monitor/customDrawer.dart';
import 'customBar.dart';
import 'ploting.dart';
import 'realtime.dart';

class RealTimePlotting extends StatefulWidget {
  const RealTimePlotting({super.key});

  @override
  RealTimePlottingState createState() => RealTimePlottingState();
}

class RealTimePlottingState extends State<RealTimePlotting> {
  List<FlSpot> dataPoints = [FlSpot(0, 0)];
  int dataCount = 0;
  late double temp; // Declare temp variable
  late RealTime realTime; // Declare RealTime variable

  @override
  void initState() {
    super.initState();
    temp = 10;

    // Initialize the RealTime widget to listen for temperature updates
    realTime = RealTime(
      onTemperatureUpdate: (temperature) {
        print("Received temperature update: $temperature");
        setState(() {
          temp = temperature.toDouble();
          dataPoints.add(FlSpot(dataCount.toDouble(), temp));
          dataCount++;
        });
      },
    );

    // Simulate real-time data updates every second
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        dataPoints.add(FlSpot(dataCount.toDouble(), temp));
        dataCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Real-time Ploting"),
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ploting(dataCount: dataCount, dataPoints: dataPoints),
          );
        },
      ),
    );
  }
}
