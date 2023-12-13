import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_monitor/customDrawer.dart';
import 'customBar.dart';

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
            child: LineChart(
              LineChartData(
                clipData: FlClipData.all(),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (value) {
                      // Customize the x-axis labels here based on your requirements
                      return value.toInt().toString();
                    },
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTitles: (value) {
                      // Display the y-axis values based on the actual data points
                      return value.toInt().toString();
                    },
                    margin: 8,
                  ),
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: const Color(0xff161A30),
                    width: 1,
                  ),
                ),
                minX: (dataCount.toDouble() - 20),
                maxX: dataCount.toDouble(),
                minY: 0,
                maxY: 20,
                lineBarsData: [
                  LineChartBarData(
                    spots:
                        dataPoints.getRange(0, dataPoints.length - 1).toList(),
                    isCurved: true,
                    colors: [const Color(0xff31304D)],
                    belowBarData: BarAreaData(
                        show: true, colors: [const Color(0xffB6BBC4)]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
