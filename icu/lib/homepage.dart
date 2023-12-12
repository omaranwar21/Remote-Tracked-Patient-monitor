import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
 const HomePage({Key? key}) : super(key: key);

 @override
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late List<LiveData> chartData;
 late ChartSeriesController _chartSeriesController;

 @override
 void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SfCartesianChart(
                borderColor: Colors.deepPurple,
                borderWidth: 2,
                series: <LineSeries<LiveData, int>>[
                 LineSeries<LiveData, int>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: chartData,
                    color: Colors.deepPurple,
                    xValueMapper: (LiveData sales, _) => sales.time,
                    yValueMapper: (LiveData sales, _) => sales.speed,
                    width: 2, // add line width
                 )
                ],
                primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                    title: AxisTitle(text: 'Time', textStyle: TextStyle(fontSize: 16, color: Colors.deepPurple))), // change axis label style
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'volts', textStyle: TextStyle(fontSize: 16, color: Colors.deepPurple))), // change axis label style
              ),
              CircularPercentIndicator(
                header: Text('SPO2', style: TextStyle(fontSize: 30, color: Colors.deepPurple)),
                animation: true,
                animationDuration: 1000,
                radius: 200,
                lineWidth: 30,
                percent: 0.8,
                progressColor: Colors.deepPurple,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text('80%', style: TextStyle(fontSize: 30, color: Colors.deepPurple)),
              ),
            ],
          ),
        ),
      ),
    );
 }

 int time = 19;
 void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
 }

 List<LiveData> getChartData() {
    return <LiveData>[
      // return data points of ecg 
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
 }
}

class LiveData {
 LiveData(this.time, this.speed);
 final int time;
 final num speed;
}
