import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:patient_monitor/widgets/customBar.dart';
import 'package:patient_monitor/widgets/customDrawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int spo2 = 0;
  bool notifyFlg = true;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("RealData");

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
            child: StreamBuilder(
                stream: dbRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Map<dynamic, dynamic>? dataMap =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
                    int spo2 = dataMap!['spo2'];
                    return CircularPercentIndicator(
                      header:
                          const Text('SPO2', style: TextStyle(fontSize: 40)),
                      animation: true,
                      animationDuration: 1000,
                      radius: 300,
                      lineWidth: 40,
                      percent: spo2 / 100,
                      progressColor: const Color(0xff161A30),
                      backgroundColor: const Color(0xffF0ECE5),
                      circularStrokeCap: CircularStrokeCap.round,
                      center:
                          Text('$spo2%', style: const TextStyle(fontSize: 50)),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}


                // RealTime(
                //   onTemperatureUpdate: (temperature) {
                //     // Update the spo2 value directly
                //     setState(() {
                //       spo2 = temperature;

                //       if (spo2 > 40 && notifyFlg) {
                //         notifyFlg = false;
                //         showNotification();
                //       }
                //       else{
                //         notifyFlg = true;
                //       }
                //     });
                //   },
                // ),

