
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel {
  String y;
  int x;

  BarChartModel({
    required this.y,
    required this.x,
  });
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final List<BarChartModel> data = [
    BarChartModel(
      y: "2014",
      x: 250,
    ),
    BarChartModel(
      y: "2015",
      x: 300,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "x",
        data: data,
        domainFn: (BarChartModel series, _) => series.y,
        measureFn: (BarChartModel series, _) => series.x,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 60, 142, 255),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: charts.BarChart(
          series,
          animate: true,
        ),
      ),
    );
  }
}