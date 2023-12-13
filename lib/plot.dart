import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_monitor/customDrawer.dart';
import 'customBar.dart';
import 'ploting.dart';

class RealTimePlotting extends StatefulWidget {
  const RealTimePlotting({super.key});

  @override
  RealTimePlottingState createState() => RealTimePlottingState();
}

class RealTimePlottingState extends State<RealTimePlotting> {
  List<FlSpot> dataPoints = []; // List to store data points for the chart
  int dataCount = 0;
  @override
  void initState() {
    super.initState();
    // Simulate real-time data updates every second
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        dataPoints.add(FlSpot(dataCount.toDouble(), generateRandomValue()));
        dataCount++;
      });
    });
  }

  double generateRandomValue() {
    // Replace this with your real-time data source
    return (10 * (1 + 0.5 * (1 - 2 * DateTime.now().second / 60))).toDouble();
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


