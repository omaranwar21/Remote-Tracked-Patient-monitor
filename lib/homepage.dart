import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'customBar.dart';
import 'customDrawer.dart';
import 'realtime.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int spo2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB6BBC4),
      appBar: CustomAppBar(title: "userName"),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  header: const Text('SPO2', style: TextStyle(fontSize: 40)),
                  animation: true,
                  animationDuration: 1000,
                  radius: 300,
                  lineWidth: 40,
                  percent: spo2 / 100,
                  progressColor: const Color(0xff161A30),
                  backgroundColor: const Color(0xffF0ECE5),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text('$spo2%', style: const TextStyle(fontSize: 50)),
                ),
                RealTime(
                  onTemperatureUpdate: (temperature) {
                    // Update the spo2 value directly
                    setState(() {
                      spo2 = temperature;

                      if (spo2 > 40){
                        showNotification();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
