import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:patient_monitor/widgets/customBar.dart';
import 'package:patient_monitor/widgets/customDrawer.dart';
import 'package:patient_monitor/widgets/ploting.dart';

class RealTimePlotting extends StatefulWidget {
  const RealTimePlotting({Key? key, this.chosneData = "Temperature"})
      : super(key: key);

  final String chosneData;

  @override
  RealTimePlottingState createState() => RealTimePlottingState();
}

class RealTimePlottingState extends State<RealTimePlotting> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("RealData");

  List<FlSpot> dataPoints = [const FlSpot(0, 0)];
  int dataCount = 0;
  late int dataValue; // Declare temp variable

  @override
  void initState() {
    super.initState();
    dataValue = 0;
    //Initialize the timer
    Timer.periodic(const Duration(milliseconds: 200), _updateData);
  }

  void _updateData(Timer timer) {
    //print("timer on");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Real-time Plotting"),
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: dbRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dataMap =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                  dataValue = dataMap![widget.chosneData];
                  dataPoints
                      .add(FlSpot(dataCount.toDouble(), dataValue.toDouble()));
                  dataCount++;

                  return Ploting(dataCount: dataCount, dataPoints: dataPoints, maximumY: 99);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
