import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_monitor/customDrawer.dart';
import 'customBar.dart';
import 'ploting.dart';
import 'realtime.dart';

class RealTimePlotting extends StatefulWidget {
  const RealTimePlotting({Key? key}) : super(key: key);

  @override
  RealTimePlottingState createState() => RealTimePlottingState();
}

class RealTimePlottingState extends State<RealTimePlotting> {
  List<FlSpot> dataPoints = [FlSpot(0, 0)];
  int dataCount = 0;
  late double temp; // Declare temp variable
  late RealTime realTime; // Declare RealTime variable
  late Timer timer; // Declare Timer variable

  @override
  void initState() {
    super.initState();
    temp = 0;

    //Initialize the timer
    timer = Timer.periodic(const Duration(milliseconds: 200), _updateData);
  }

  void _updateData(Timer timer) {
    //print("timer on");
    setState(() {
      dataPoints.add(FlSpot(dataCount.toDouble(), temp));
      dataCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Real-time Plotting"),
      drawer: CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 30, // Adjust the flex factor to control the ratio
                  child: Ploting(dataCount: dataCount, dataPoints: dataPoints),
                ),
                Expanded(
                  flex: 1, // Adjust the flex factor to control the ratio
                  child: RealTime(
                    onTemperatureUpdate: (temperature) {
                     // print("Received temperature update: $temperature");
                      setState(() {
                        temp = temperature.toDouble();
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
