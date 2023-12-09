import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                header:Text('SPO2', style:TextStyle(fontSize: 40)) ,
                animation: true,
                animationDuration: 1000,
                radius: 300,
                lineWidth: 40,
                percent: 0.8,
                progressColor: Colors.deepPurple,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text('80%', style:TextStyle(fontSize: 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}